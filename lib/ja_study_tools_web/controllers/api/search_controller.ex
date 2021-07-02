defmodule JaStudyToolsWeb.API.SearchController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.SearchAPI

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, req) do
    case JaStudyToolsWeb.Models.SearchRequest.validate(req) do
      {:ok, res} ->
        {:ok, results} = SearchAPI.search_vocab(res.term, res.page)
        render(
          conn,
          "results_paginated.json",
          vocab: results.terms,
          current_page: 0,
          total_pages: results.total_pages
        )
      {:error, msg} -> render(conn, "error.json", msg: msg)
    end
  end
end
