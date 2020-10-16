defmodule JaStudyToolsWeb.API.KanjiControllerTest do
  use JaStudyToolsWeb.ConnCase

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  @create_attrs %{
    character: "some character",
    grade: "some grade",
    jlpt_level: 42,
    kunyomi: [],
    meanings: [],
    onyomi: [],
    stroke_count: 42
  }
  @update_attrs %{
    character: "some updated character",
    grade: "some updated grade",
    jlpt_level: 43,
    kunyomi: [],
    meanings: [],
    onyomi: [],
    stroke_count: 43
  }
  @invalid_attrs %{character: nil, grade: nil, jlpt_level: nil, kunyomi: nil, meanings: nil, onyomi: nil, stroke_count: nil}

  def fixture(:kanji) do
    {:ok, kanji} = Dictionary.create_kanji(@create_attrs)
    kanji
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "it sets default offset and limit if missing in params", %{conn: conn} do
      conn = get(conn, Routes.kanji_path(conn, :index))
      assert json_response(conn, 200)["data"] == %{
        "kanji" => [],
        "next" => Routes.kanji_path(conn, :index, offset: 25, limit: 25)
      }
    end

    test "it sets default offset if missing in params", %{conn: conn} do
      conn = get(conn, Routes.kanji_path(conn, :index, limit: 250))
      assert json_response(conn, 200)["data"] == %{
        "kanji" => [],
        "next" => Routes.kanji_path(conn, :index, offset: 250, limit: 250)
      }
    end

    test "it returns the correct offset for the next link", %{conn: conn} do
      conn = get(conn, Routes.kanji_path(conn, :index, offset: 100, limit: 50))
      assert json_response(conn, 200)["data"] == %{
        "kanji" => [],
        "next" => Routes.kanji_path(conn, :index, offset: 150, limit: 50)
      }
    end

    test "it returns 400 response if offset invalid integer value", %{conn: conn} do
      conn = get(conn, Routes.kanji_path(conn, :index, offset: "five", limit: 50))
      assert json_response(conn, 400)["error"] =~ "offset"
    end

    test "it returns a 400 response if limit invalid integer value", %{conn: conn} do
      conn = get(conn, Routes.kanji_path(conn, :index, offset: "100", limit: "limit"))
      assert json_response(conn, 400)["error"] =~ "limit"
    end

    test "it returns a 400 response if limit is > 500", %{conn: conn} do
      conn = get(conn, Routes.kanji_path(conn, :index, offset: "100", limit: 1000))
      assert json_response(conn, 400)["error"] =~ "Limit cannot exceed"
    end
  end

  defp create_kanji(_) do
    kanji = fixture(:kanji)
    %{kanji: kanji}
  end
end
