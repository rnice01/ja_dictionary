defmodule JaStudyToolsWeb.API.TokenizerController do
  use JaStudyToolsWeb, :controller

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, req) do
    render(conn, "index.json", results: %{text: req["text"]})
  end
end
