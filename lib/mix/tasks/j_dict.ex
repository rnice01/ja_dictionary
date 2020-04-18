defmodule Mix.Tasks.JDict.Import do
  use Mix.Task
  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.Kanji
  alias JStudyBlog.Repo
  alias Ecto.Multi
  alias JStudyBlog.JDict.XMLParser

  @shortdoc "Imports the JDictionary and Kanjidic XML files to the database"
  def run(_) do
    Mix.Task.run("app.start")
    #import_k_dict()
    import_j_dict()
  end

  def import_k_dict() do
    File.stream!(Application.app_dir(:j_study_blog, "priv/kanjidic2.xml"))
    |> XMLParser.parse_kanji
    |> Stream.chunk_every(25)
    |> Enum.each(fn kanji ->
      Repo.insert_all(Kanji, kanji)
    end)
  end

  def import_j_dict() do
    File.stream!(Application.app_dir(:j_study_blog, "priv/JMdict_e"))
    |> XMLParser.parse_vocab
    |> Stream.chunk_every(25)
    |> Enum.each(fn vocabs ->
      insert_vocab_entry(vocabs)
    end)
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
