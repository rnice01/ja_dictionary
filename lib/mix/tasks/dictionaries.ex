"""
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
  end

  def import_k_dict() do
    File.stream!(Application.app_dir(:j_study_blog, "priv/kanjidic2.xml"))
    |> XMLParser.parse_kanji
    |> Stream.chunk_every(25)
    |> Enum.each(fn kanji ->
      Repo.insert_all(Kanji, kanji)
    end)
  end
end
"""
