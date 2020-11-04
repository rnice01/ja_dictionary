defmodule JaStudyToolsWeb.API.KanjiView do
  use JaStudyToolsWeb, :view
  alias JaStudyToolsWeb.API.KanjiView

  def render("list.json", %{kanjis: kanjis, next: next}) do
    %{
      data: %{
        kanji: Enum.map(kanjis, fn k ->
          %{
            id: k.id,
            character: k.character,
            kunyomi: k.kunyomi,
            onyomi: k.onyomi,
            meanings: k.meanings,
            stroke_count: k.stroke_count,
            jlpt_level: k.jlpt_level,
          }
        end),
        next: next
      }
    }
  end

  def render("index.json", %{kanjis: kanjis}) do
    %{data: render_many(kanjis, KanjiView, "kanji.json")}
  end

  def render("show.json", %{kanji: kanji}) do
    %{data: render_one(kanji, KanjiView, "kanji.json")}
  end

  def render("kanji.json", %{kanji: kanji}) do
    %{id: kanji.id,
      character: kanji.character,
      kunyomi: kanji.kunyomi,
      onyomi: kanji.onyomi,
      meanings: kanji.meanings,
      stroke_count: kanji.stroke_count,
      jlpt_level: kanji.jlpt_level,
      grade: kanji.grade}
  end
end
