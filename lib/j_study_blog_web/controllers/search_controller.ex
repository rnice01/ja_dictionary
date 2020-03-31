defmodule JStudyBlogWeb.SearchController do
  use JStudyBlogWeb, :controller

  alias JStudyBlog.Dictionary

  action_fallback JStudyBlogWeb.FallbackController

  def index(conn, %{"kanji" => k}) do
    searches = Dictionary.search_by_kanji(k)
    render(conn, "index.json", searches: searches)
  end
end
