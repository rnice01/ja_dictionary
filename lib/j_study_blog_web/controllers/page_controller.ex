defmodule JStudyBlogWeb.PageController do
  use JStudyBlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
