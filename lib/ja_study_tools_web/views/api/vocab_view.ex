defmodule JaStudyToolsWeb.API.VocabView do
  use JaStudyToolsWeb, :view
  alias JaStudyToolsWeb.API.VocabView

  def render("index.json", %{vocab: vocab}) do
    %{data: render_many(vocab, VocabView, "vocab.json")}
  end

  def render("show.json", %{vocab: vocab}) do
    %{data: render_one(vocab, VocabView, "vocab.json")}
  end

  def render("vocab.json", %{vocab: vocab}) do
    %{id: vocab.id,
      kanji_reading: vocab.kanji_reading,
      kana: vocab.kana,
      meanings: vocab.meanings,
      parts_of_speech: vocab.parts_of_speech,
      alternate_readings: Enum.map(vocab.alternate_readings, fn ar -> %{kanji: ar.kanji, kana: ar.kana} end),
      kanji: Enum.map(vocab.kanji, fn k -> 
      %{
        character: k.character,
        kunyomi: k.kunyomi,
        onyomi: k.onyomi,
        stroke_count: k.stroke_count,
        jlpt_level: k.jlpt_level,
        grade: k.grade
      }
      end)
    }
  end
end
