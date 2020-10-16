defmodule JaStudyToolsWeb.API.DictionaryController do
  use JaStudyToolsWeb.ConnCase
  import JaStudyTools.Testing.Factory

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

end