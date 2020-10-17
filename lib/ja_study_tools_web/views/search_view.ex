defmodule JaStudyToolsWeb.API.SearchView do
  use JaStudyToolsWeb, :view
  alias JaStudyToolsWeb.SearchView

  def render("results.json", %{kanji: kanji}) do
    %{data: Enum.map(kanji, fn k -> 
      %{
        id: k.id,
        character: k.character,
        kunyomi: k.kunyomi,
        onyomi: k.onyomi,
        meanings: k.meanings,
        stroke_count: k.stroke_count,
        jlpt_level: k.jlpt_level,
        grade: k.grade
      }
    end)
    }
  end
end
