defmodule JaStudyToolsWeb.API.SearchController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, %{"kanji" => kanji}) do
    kanji = Dictionary.by_kanji!(kanji)
    render(conn, "kanji.json", kanji: kanji)
  end
end