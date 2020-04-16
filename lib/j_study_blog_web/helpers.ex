defmodule JStudyBlogWeb.Helpers do

  @spec vocab_to_json_map(
          JStudyBlog.Dictionary.Vocab.t
        ) :: %{
          alternate_readings: [any],
          id: any,
          kana: String.t,
          kanji: String.t,
          meanings: [String.t],
          parts_of_speech: [String.t]
        }
  def vocab_to_json_map(vocab) do
    %{
      "id" => vocab.id,
      "kanji" => vocab.kanji_reading,
      "kana" => vocab.kana_reading,
      "meanings" => vocab.meanings,
      "alternate_readings" => Enum.map(vocab.alternate_readings, fn %{kanji_reading: kj, kana_reading: ka} -> %{"kanji" => kj, "kana" => ka} end),
      "parts_of_speech" => vocab.parts_of_speech
    }
  end
end
