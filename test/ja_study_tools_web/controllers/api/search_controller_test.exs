defmodule JaStudyToolsWeb.API.SearchControllerTest do
  use JaStudyToolsWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "POST /api/v1/dictionary/search", %{conn: conn} do
    conn = post(conn, Routes.search_path(conn, :index, term: "test"))
    assert json_response(conn, 200) == %{
      "data" => %{
        "totalPages" => 1,
        "currentPage" => 1,
        "resultsCount" => 0,
         "vocabResults" => []
       }
      }
  end
end