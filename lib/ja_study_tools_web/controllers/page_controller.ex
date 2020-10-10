defmodule JaStudyToolsWeb.PageController do
  use JaStudyToolsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
