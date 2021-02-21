defmodule JaStudyTools.JDicts.YomichanParser do
  @behaviour JaStudyTools.JDicts.DictParser

  @impl JaStudyTools.JDicts.DictParser
  def read_kanji(binary_contents) do
    Jason.decode(binary_contents) |> parse_kanji
  end

  defp parse_kanji({:error, err}), do: IO.puts(err.data)

  defp parse_kanji({:ok, json}) do
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
  def read_vocab(binary_contents) do
    Jason.decode(binary_contents) |> parse_vocab
  end

  defp parse_vocab({:ok, json}) do
    json
    |> Enum.map(fn vocab_data ->
      [term, reading, pos, _tags, _, meanings | _] = vocab_data
      %{
         term: term,
         reading: reading,
         meanings: meanings,
         parts_of_speech: String.split(pos),
      }
    end)
  end

  defp parse_vocab({:error, err}), do: IO.puts(err.data)
end
