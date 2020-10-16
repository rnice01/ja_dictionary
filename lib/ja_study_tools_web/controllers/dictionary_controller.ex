defmodule JaStudyToolsWeb.API.DictionaryController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  action_fallback JaStudyToolsWeb.FallbackController

  def search(conn, %{"kanji" => kanji}) do
    kanji = Dictionary.get_kanji!(1)
    render(conn, "kanji.json", kanji: kanji)
  end
end
