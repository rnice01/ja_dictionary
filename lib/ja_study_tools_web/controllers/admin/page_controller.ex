defmodule JaStudyToolsWeb.Admin.PageController do
  use JaStudyToolsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def dictionary(conn, _) do
    render(conn, "dictionary.html")
  end
end
