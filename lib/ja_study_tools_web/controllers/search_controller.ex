defmodule JaStudyToolsWeb.API.SearchController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, %{"term" => term}) do
    kanji = Dictionary.search!(term)
    render(conn, "results.json", kanji: kanji)
  end
end
