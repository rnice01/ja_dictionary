defmodule Mix.Tasks.Dict.Import do
  use Mix.Task
  alias JaStudyTools.Dictionary.Kanji
  alias JaStudyTools.Dictionary.Vocab
  alias JaStudyTools.Dictionary.VocabAlternateReading
  alias JaStudyTools.Repo
  alias JaStudyTools.JDicts.XMLParser

  @shortdoc "Imports the JDictionary and Kanjidic XML files to the database"
  def run(_) do
    Mix.Task.run("app.start")
    import_k_dict()
    import_j_dict()
  end

  def import_k_dict() do
    File.stream!(Application.app_dir(:ja_study_tools, "priv/data/kanjidic2.xml"))
    |> XMLParser.parse_kanji
    |> Stream.chunk_every(100)
    |> Enum.each(fn kanji ->
      Repo.insert_all(Kanji, kanji)
    end)
  end

  def import_j_dict() do
    File.stream!(Application.app_dir(:ja_study_tools, "priv/data/JMdict_e"))
    |> XMLParser.parse_vocab
    |> Stream.chunk_every(100)
    |> Enum.each(fn vocabs ->
      vocab =
        Enum.map(vocabs, fn v -> 
          %{
            kanji_reading: v.kanji,
            kana: v.kana,
            meanings: v.meanings,
            parts_of_speech: v.parts_of_speech,
            alternate_readings: Enum.map(v.alternate_readings, fn ar -> 
              %VocabAlternateReading{
                kanji: ar.kanji,
                kana: ar.kana
              }
            end)
          }
        end)
      {_, vocabs} = Repo.insert_all(Vocab, vocab, returning: [:id, :kanji_reading])

      kanji_vocabs = Enum.flat_map(vocabs, fn v ->
        JaStudyTools.Dictionary.find_kanji_by_characters(v.kanji_reading)
        |> Enum.map(fn k -> %{vocab_id: v.id, kanji_id: k.id} end)
      end)
      
      Repo.insert_all("vocab_kanjis", kanji_vocabs)
    end)
  end
end
