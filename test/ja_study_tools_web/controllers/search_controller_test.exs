defmodule JaStudyToolsWeb.SearchControllerTest do
  use JaStudyToolsWeb.ConnCase
  import JaStudyTools.Testing.Factory

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Search

  describe "index" do
    test "when searching by kanji character, it returns the expected kanji", %{conn: conn} do
      kanji = insert(:kanji)
      conn = post(conn, Routes.search_path(conn, :index, term: kanji.character))
      assert json_response(conn, 200)["data"] == [%{
        "id" => kanji.id,
        "character" => kanji.character,
        "kunyomi" => kanji.kunyomi,
        "onyomi" => kanji.onyomi,
        "meanings" => kanji.meanings,
        "stroke_count" => kanji.stroke_count,
        "jlpt_level" => kanji.jlpt_level,
        "grade" => kanji.grade
      }]
    end

    test "when searching by kanji meaning, it returns the expected kanji", %{conn: conn} do
      kanji = insert(:kanji)
      [primary_meaning | _] = kanji.meanings
      conn = post(conn, Routes.search_path(conn, :index, term: primary_meaning))
      assert json_response(conn, 200)["data"] == [%{
        "id" => kanji.id,
        "character" => kanji.character,
        "kunyomi" => kanji.kunyomi,
        "onyomi" => kanji.onyomi,
        "meanings" => kanji.meanings,
        "stroke_count" => kanji.stroke_count,
        "jlpt_level" => kanji.jlpt_level,
        "grade" => kanji.grade
      }]
    end

    test "when searching by onyomi, it returns the expected kanji", %{conn: conn} do
      kanji = insert(:kanji)
      [on_reading | _] = kanji.onyomi
      conn = post(conn, Routes.search_path(conn, :index, term: on_reading))
      assert json_response(conn, 200)["data"] == [%{
        "id" => kanji.id,
        "character" => kanji.character,
        "kunyomi" => kanji.kunyomi,
        "onyomi" => kanji.onyomi,
        "meanings" => kanji.meanings,
        "stroke_count" => kanji.stroke_count,
        "jlpt_level" => kanji.jlpt_level,
        "grade" => kanji.grade
      }]
    end
    
    test "when searching by kunyomi, it returns the expected kanji", %{conn: conn} do
      kanji = insert(:kanji)
      [kun_reading | _] = kanji.kunyomi
      conn = post(conn, Routes.search_path(conn, :index, term: kun_reading))
      assert json_response(conn, 200)["data"] == [%{
        "id" => kanji.id,
        "character" => kanji.character,
        "kunyomi" => kanji.kunyomi,
        "onyomi" => kanji.onyomi,
        "meanings" => kanji.meanings,
        "stroke_count" => kanji.stroke_count,
        "jlpt_level" => kanji.jlpt_level,
        "grade" => kanji.grade
      }]
    end
  end
end
