defmodule JaStudyToolsWeb.API.SearchController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, req) do
    case JaStudyToolsWeb.Models.SearchRequest.validate(req) do
      {:ok, res} -> 
        results = Dictionary.search(res.term, res.page, res.limit)
        render(
          conn,
          "results_paginated.json",
          vocab: results.entries,
          current_page: results.page_number,
          total_pages: results.total_pages
        )
      {:error, msg} -> render(conn, "error.json", msg: msg)
    end
  end
end
