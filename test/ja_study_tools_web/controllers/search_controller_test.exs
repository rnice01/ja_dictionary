defmodule JaStudyToolsWeb.SearchControllerTest do
  use JaStudyToolsWeb.ConnCase
  import JaStudyTools.Testing.Factory

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Search

  describe "index" do
    test "when searching by kanji, it returns the expected character", %{conn: conn} do
      kanji = insert(:kanji)
      conn = post(conn, Routes.search_path(conn, :index, kanji: kanji.character))
      assert json_response(conn, 200)["data"] == %{
        "id" => kanji.id,
        "character" => kanji.character,
        "kunyomi" => kanji.kunyomi,
        "onyomi" => kanji.onyomi,
        "meanings" => kanji.meanings,
        "stroke_count" => kanji.stroke_count,
        "jlpt_level" => kanji.jlpt_level,
        "grade" => kanji.grade
      }
    end
  end
end
