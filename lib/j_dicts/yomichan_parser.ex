defmodule JaStudyTools.JDicts.YomichanParser do
  @behaviour JaStudyTools.JDicts.DictParser

  @impl JaStudyTools.JDicts.DictParser
  def read_kanji(binary_contents) do
    case Jason.decode(binary_contents) do
      {:ok, contents} -> parse_kanji(contents)
      {:error, err} -> IO.puts(err.data)
    end
  end

  defp parse_kanji(json) do
    json
    |> Enum.map(fn kanji_data ->
      [kanji, onyomi, kunyomi, _, meanings, misc_data] = kanji_data

      stroke_count = case Integer.parse(misc_data["strokes"]) do
        {int, _} -> int
        :error -> 0
      end

        %{
          character: kanji,
          stroke_count: stroke_count,
          jlpt_level: 0,
          grade: "",
          meanings: meanings,
          onyomi: String.split(onyomi),
          kunyomi: String.split(kunyomi),
        }
    end)
  end

  @impl JaStudyTools.JDicts.DictParser
  def read_vocab(file) do

  end

  def stream_kanji(_) do end
  def stream_vocab(_) do end
end
