defmodule Mix.Tasks.Dict.Import do
  use Mix.Task
  alias JaStudyTools.Dictionary.Kanji
  alias JaStudyTools.Repo
  alias JaStudyTools.JDicts.XMLParser

  @shortdoc "Imports the JDictionary and Kanjidic XML files to the database"
  def run(_) do
    Mix.Task.run("app.start")
    import_k_dict()
  end

  def import_k_dict() do
    File.stream!(Application.app_dir(:ja_study_tools, "priv/data/kanjidic2.xml"))
    |> XMLParser.parse_kanji
    |> Stream.chunk_every(100)
    |> Enum.each(fn kanji ->
      kanji =
        Enum.filter(kanji, fn k -> Map.get(k, :jlpt_level) != nil end)

      Repo.insert_all(Kanji, kanji)
    end)
  end
end
