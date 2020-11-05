defmodule JaStudyToolsWeb.API.SearchController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, %{"term" => term}) do
    vocab = Dictionary.search_vocab(term)
    render(conn, "results.json", vocab: vocab)
  end
end
