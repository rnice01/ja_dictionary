defmodule Mix.Tasks.Dict.Import do
  import SweetXml
  use Mix.Task
  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.VocabMeaning
  alias JStudyBlog.Repo
  alias JStudyBlog.JDict.VocabEntry
  alias Ecto.Multi

  @shortdoc "Imports the JDictionary and Kanjidic XML files to the database"
  def run(_) do
    Mix.Task.run("app.start")
    stream = File.stream!(Application.app_dir(:j_study_blog, "priv/JMdict_e"))

    vocabs = stream
    |> stream_tags([:entry], discard: [:entry])
    |> Stream.map(fn
      {_, entry} ->
        entry_to_vocabs(%VocabEntry{
          kanji_readings: entry |> xpath(~x"./k_ele/keb/text()"ls),
          kana_readings: entry |> xpath(~x"./r_ele/reb/text()"ls),
          meanings: entry|> xpath(~x"./sense/gloss/text()"ls),
          parts_of_speech: entry |> xpath(~x"./sense/pos/text()"ls)
        })
      end)
    |> Enum.to_list
    |> List.flatten

    for vocab <- vocabs do
      IO.inspect vocab
      insert_vocab(vocab)
    end
  end

  def insert_vocab(vocab) do
    Multi.new()
    |> Multi.insert(JStudyBlog.Dictionary.Vocab, vocab)
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
            kanji: "",
            kana: kana,
            meanings: Enum.map(meanings, fn m -> %VocabMeaning{definition: m, language: "en-us"} end)
          }
        end
      _ ->
        [primary_kanji | alternate_kanjis] = kanjis
        [primary_kana | alternate_kanas] = kanas

        alternate_vocabs = for {kanji, kana} <- Enum.zip(alternate_kanjis, alternate_kanas) do
          %Vocab{
            kanji: kanji,
            kana: kana
          }
        end
          
        [%Vocab {
          kanji: primary_kanji,
          kana: primary_kana,
          alternate_kanji: alternate_vocabs,
          meanings: Enum.map(meanings, fn m -> %VocabMeaning{definition: m, language: "en-us"} end)
        }]
    end
  end
end