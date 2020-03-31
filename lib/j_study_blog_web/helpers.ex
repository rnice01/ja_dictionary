defmodule JStudyBlogWeb.Helpers do

  @spec vocab_to_json_map(
          JStudyBlog.Dictionary.Vocab.t
        ) :: %{
          alternate_readings: [any],
          id: any,
          kana: String.t,
          kanji: String.t,
          meanings: [%{definition: String.t, language: String.t}],
          parts_of_speech: [%{code: String.t, description: String.t}]
        }
  def vocab_to_json_map(vocab) do
    %{
      "id" => vocab.id,
      "kanji" => vocab.kanji,
      "kana" => vocab.kana,
      "meanings" => Enum.map(vocab.meanings, fn %{definition: d, language: l} -> %{"definition" => d, "language" => l} end),
      "alternate_readings" => Enum.map(vocab.alternate_readings, fn %{kanji: kj, kana: ka} -> %{"kanji" => kj, "kana" => ka} end),
      "parts_of_speech" => Enum.map(vocab.parts_of_speech, fn pos -> %{"code" => pos.code, "description" => pos.description} end)
    }
  end
end
