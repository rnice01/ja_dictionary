defmodule Mix.Tasks.JDict.Import do
  import SweetXml
  use Mix.Task
  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.VocabMeaning
  alias JStudyBlog.Dictionary.PartOfSpeech
  alias JStudyBlog.Dictionary.VocabPartsOfSpeech
  alias JStudyBlog.Repo
  alias JStudyBlog.JDict.VocabEntry
  alias Ecto.Multi

  @shortdoc "Imports the JDictionary and Kanjidic XML files to the database"
  def run(_) do
    Mix.Task.run("app.start")
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
        |> insert_entry
      end)
      |> Enum.to_list
  end

  def insert_entry(entry) do
    parts = Enum.map(entry.parts_of_speech, fn p ->
      pos = Repo.get_by(PartOfSpeech, code: p)
      if pos == nil do
        {:ok, pos} = Repo.insert(%PartOfSpeech{code: p, description: ""})
        pos
      else
        pos
      end
    end)

    vocabs = entry_to_vocabs(entry)


    for vocab <- vocabs do
      Multi.new()
      |> Multi.insert(Vocab, vocab)
      |> Multi.run(:parts, fn _repo, %{JStudyBlog.Dictionary.Vocab => v} ->
          Enum.each(parts, fn p ->
            part = %VocabPartsOfSpeech{parts_of_speech_id: p.id, vocab_id: v.id}
            Multi.new()
            |> Multi.insert(VocabPartsOfSpeech, part)
            |> Repo.transaction()
          end)
          {:ok, 1}
        end)
      |> Repo.transaction()
    end
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
            kanji: "",
            kana: kana,
            meanings: Enum.map(meanings, fn m -> %VocabMeaning{definition: m, language: "en-us"} end)
          }
        end
      _ ->
        [primary_kanji | alternate_readingss] = kanjis
        [primary_kana | alternate_kanas] = kanas

        alternate_vocabs = for {kanji, kana} <- Enum.zip(alternate_readingss, alternate_kanas) do
          %Vocab{
            kanji: kanji,
            kana: kana
          }
        end

        [%Vocab {
          kanji: primary_kanji,
          kana: primary_kana,
          alternate_readings: alternate_vocabs,
          meanings: Enum.map(meanings, fn m -> %VocabMeaning{definition: m, language: "en-us"} end)
        }]
    end
  end
end
