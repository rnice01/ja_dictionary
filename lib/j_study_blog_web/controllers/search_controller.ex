defmodule JStudyBlogWeb.SearchController do
  use JStudyBlogWeb, :controller

  alias JStudyBlog.Dictionary

  action_fallback JStudyBlogWeb.FallbackController

  def index(conn, _) do
    render(conn, "index.html")
  end

  def search(conn, %{"search" => %{"kanji" => k}}) do
    searches = Dictionary.search_by_kanji(k)
    render(conn, "results.html", vocabs: searches.vocabs)
  end
end
