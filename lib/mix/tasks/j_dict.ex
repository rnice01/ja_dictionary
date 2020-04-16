defmodule Mix.Tasks.JDict.Import do
  import SweetXml
  use Mix.Task
  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.Kanji
  alias JStudyBlog.Repo
  alias JStudyBlog.JDict.VocabEntry
  alias Ecto.Multi

  @shortdoc "Imports the JDictionary and Kanjidic XML files to the database"
  def run(_) do
    Mix.Task.run("app.start")
    import_k_dict()
    #import_j_dict()
  end

  def import_k_dict() do
    stream = File.stream!(Application.app_dir(:j_study_blog, "priv/kanjidic2.xml"))

    stream
    |> stream_tags([:character], discard: [:character])
    |> Stream.map(fn
      {_, entry} ->
        now_time = NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)
        %{
          character: entry |> xpath(~x"./literal/text()"s),
          stroke_count: entry |> xpath(~x"./misc/stroke_count/text()"i),
          jlpt_level: entry |> xpath(~x"./misc/jlpt/text()"s),
          grade: entry |> xpath(~x"./misc/grade/text()"s),
          meanings: entry|> xpath(~x"./reading_meaning/rmgroup/meaning[not(@*)]/text()"ls),
          kunyomi: entry |> xpath(~x"./reading_meaning/rmgroup/reading[@r_type='ja_on']/text()"ls),
          onyomi: entry |> xpath(~x"./reading_meaning/rmgroup/reading[@r_type='ja_kun']/text()"ls),
          inserted_at: now_time,
          updated_at: now_time
        }
      end)
    |> Stream.chunk_every(25)
    |> Enum.each(fn kanji ->
      Repo.insert_all(Kanji, kanji)
    end)
  end

  def import_j_dict() do
    stream = File.stream!(Application.app_dir(:j_study_blog, "priv/JMdict_e"))

    stream
    |> stream_tags([:entry], discard: [:entry])
    |> Stream.map(fn
      {_, entry} ->
        %VocabEntry{
          kanji_readings: entry |> xpath(~x"./k_ele/keb/text()"ls),
          kana_readings: entry |> xpath(~x"./r_ele/reb/text()"ls),
          meanings: entry|> xpath(~x"./sense/gloss/text()"ls),
          parts_of_speech: entry |> xpath(~x"./sense/pos/text()"ls)
        }
        |> insert_vocab_entry
      end)
      |> Enum.to_list
  end

  def insert_vocab_entry(entry) do
    vocabs = entry_to_vocabs(entry)

    Multi.new()
    |> Multi.insert_all(:insert_all, Vocab, vocabs)
    |> Repo.transaction()
  end

  def entry_to_vocabs(entry) do
    %{
      kanji_readings: kanjis,
      kana_readings: kanas,
      meanings: meanings
    } = entry

    case length(kanjis) do
      0 ->
        for kana <- kanas do
          %Vocab{
            kanji_reading: "",
            kana_reading: kana,
            meanings: meanings
          }
        end
      _ ->
        [primary_kanji | alternate_readingss] = kanjis
        [primary_kana | alternate_kanas] = kanas

        alternate_vocabs = for {kanji, kana} <- Enum.zip(alternate_readingss, alternate_kanas) do
          %Vocab{
            kanji_reading: kanji,
            kana_reading: kana
          }
        end

        [%Vocab {
          kanji_reading: primary_kanji,
          kana_reading: primary_kana,
          alternate_readings: alternate_vocabs,
          meanings: meanings
        }]
    end
  end
end
