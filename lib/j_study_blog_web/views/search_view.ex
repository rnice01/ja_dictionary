defmodule JStudyBlogWeb.SearchView do
  use JStudyBlogWeb, :view
  alias JStudyBlogWeb.SearchView
  alias JStudyBlogWeb.Helpers

  def render("index.json", %{searches: searches}) do
    %{vocabs: vocabs} = searches
    %{data: %{
        vocabs: Enum.map(vocabs, fn v ->
          Helpers.vocab_to_json_map(v)
        end)
      }
    }
  end

  def render("show.json", %{search: search}) do
    %{data: render_one(search, SearchView, "search.json")}
  end

  def render("search.json", %{search: search}) do
    search
  end
end
