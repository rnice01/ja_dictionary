defmodule Mix.Tasks.Dict.Yomichan do
  use Mix.Task
  alias JaStudyTools.Dictionary.Kanji
  alias JaStudyTools.Dictionary.Vocab
  alias JaStudyTools.Repo
  alias JaStudyTools.JDicts.YomichanParser

  @shortdoc "Imports the JDictionary and Kanjidic Yomichan files to the database"
  def run(_) do
    Mix.Task.run("app.start")
    import_jdict()
  end

  defp import_jdict() do
    recursive_ls(Application.app_dir(:ja_study_tools, "priv/data/yomichan_jdict"))
    |> Enum.each(fn path ->
      vocab = YomichanParser.read_vocab(File.read!(path))

      Repo.insert_all(Vocab, vocab, returning: [:id, :term, :reading, :meanings])
      |> insert_searches
    end)
  end

  defp insert_searches({_, vocab}) do
      vocab_searches = vocab
      |> Enum.map(fn v -> v |> build_vocab_searchable end)

      JaStudyTools.SearchIndex.insert_vocab_searchable(vocab_searches)
  end

  defp recursive_ls(path) do
    cond do
      File.regular?(path) -> [path]
      File.dir?(path) ->
        File.ls!(path)
        |> Enum.map(&Path.join(path, &1))
        |> Enum.map(&recursive_ls/1)
        |> Enum.concat
      true -> []
    end
  end

  defp build_vocab_searchable(vocab) do
    %{
      id: vocab.id,
      term: vocab.term,
      reading: vocab.reading,
      meanings: vocab.meanings,
      parts_of_speech: vocab.parts_of_speech
    }
  end
end
