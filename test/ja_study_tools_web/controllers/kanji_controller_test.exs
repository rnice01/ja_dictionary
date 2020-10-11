defmodule JaStudyToolsWeb.KanjiControllerTest do
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
    test "it sets default pagination if missing in params", %{conn: conn} do
      conn = get(conn, Routes.kanji_path(conn, :index))
      assert json_response(conn, 200)["data"] == %{
        "kanji" => [],
        "next" => Routes.kanji_path(conn, :index, offset: 25, limit: 25)
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

  describe "create kanji" do
    test "renders kanji when data is valid", %{conn: conn} do
      conn = post(conn, Routes.kanji_path(conn, :create), kanji: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.kanji_path(conn, :show, id))

      assert %{
               "id" => id,
               "character" => "some character",
               "grade" => "some grade",
               "jlpt_level" => 42,
               "kunyomi" => [],
               "meanings" => [],
               "onyomi" => [],
               "stroke_count" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.kanji_path(conn, :create), kanji: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update kanji" do
    setup [:create_kanji]

    test "renders kanji when data is valid", %{conn: conn, kanji: %Kanji{id: id} = kanji} do
      conn = put(conn, Routes.kanji_path(conn, :update, kanji), kanji: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.kanji_path(conn, :show, id))

      assert %{
               "id" => id,
               "character" => "some updated character",
               "grade" => "some updated grade",
               "jlpt_level" => 43,
               "kunyomi" => [],
               "meanings" => [],
               "onyomi" => [],
               "stroke_count" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, kanji: kanji} do
      conn = put(conn, Routes.kanji_path(conn, :update, kanji), kanji: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete kanji" do
    setup [:create_kanji]

    test "deletes chosen kanji", %{conn: conn, kanji: kanji} do
      conn = delete(conn, Routes.kanji_path(conn, :delete, kanji))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.kanji_path(conn, :show, kanji))
      end
    end
  end

  defp create_kanji(_) do
    kanji = fixture(:kanji)
    %{kanji: kanji}
  end
end
