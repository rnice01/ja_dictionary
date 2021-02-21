defmodule Mix.Tasks.Dict.Import do
  use Mix.Task
  alias JaStudyTools.Dictionary.Kanji
  alias JaStudyTools.Dictionary.Vocab
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
            term: v.term,
            reading: v.reading,
            meanings: v.meanings,
            parts_of_speech: v.parts_of_speech
          }
        end)
      {_, vocabs} = Repo.insert_all(Vocab, vocab, returning: [:id, :term, :reading, :meanings])

      kanji_vocabs = Enum.flat_map(vocabs, fn v ->
        JaStudyTools.Dictionary.find_kanji_by_characters(v.term)
        |> Enum.map(fn k -> %{vocab_id: v.id, kanji_id: k.id} end)
      end)

      vocab_searches = Enum.map(vocabs, fn v -> v |> build_vocab_searchable end)

      Repo.insert_all("vocab_kanjis", kanji_vocabs)
      Repo.insert_all("searches", vocab_searches)
    end)
  end

  defp build_vocab_searchable(vocab) do
    %{
      vocab_id: vocab.id,
      english_text: Enum.join(vocab.meanings, ","),
      japanese_text: Enum.join([
        vocab.term,
        vocab.reading
      ], ",")
    }
  end
end
