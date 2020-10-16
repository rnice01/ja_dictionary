defmodule JaStudyToolsWeb.API.SearchView do
  use JaStudyToolsWeb, :view
  alias JaStudyToolsWeb.SearchView

  def render("kanji.json", %{kanji: k}) do
    %{
      data: %{
          id: k.id,
          character: k.character,
          kunyomi: k.kunyomi,
          onyomi: k.onyomi,
          meanings: k.meanings,
          stroke_count: k.stroke_count,
          jlpt_level: k.jlpt_level,
          grade: k.grade
      }
    }
  end
end
