defmodule JaStudyToolsWeb.API.VocabController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.Dictionary

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, _params) do
    vocab = Dictionary.list_vocab(0, 50)
    render(conn, "index.json", vocab: vocab)
  end

  def search(conn, %{"search_term" => term}) do
    vocab = Dictionary.search(term)
    render(conn, "index.json", vocab: vocab)
  end
end
