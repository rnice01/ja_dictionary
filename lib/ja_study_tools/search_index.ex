defmodule JaStudyTools.SearchIndex do
  @type SearchIndexResponse {
    page: String.t()
  }
  def insert_searchable_terms(terms) do
    HTTPoison.post(base_url() <> "/ja_study/_bulk", bulk_params(terms), [{"Content-Type", "application/json"}])
  end

  def search_terms(query) do
    case HTTPoison.post(base_url() <> "/ja_study/_search", term_search_params(query), [{"Content-Type", "application/json"}]) do
      {:ok, res} ->
    end
  end

  defp term_search_params(search_by) do
    Jason.encode!(%{
      query: %{
        multi_match: %{
          type: "best_fields",
          query: search_by,
          fields: ["term", "reading", "meanings"],
          tie_breaker: 0
        }
      }
    })
  end

  defp bulk_params(terms) do
    Enum.reduce(terms, "", fn term, acc ->
      meanings = Enum.join(term.meanings, "\", \"")
      acc <> """
       {"index":{"_index":"ja_study", "_id": "#{term.id}"}}
       {"term": "#{term.term}", "reading": "#{term.reading}", "meanings": ["#{meanings}"]}
      """
    end)
  end

  defp base_url() do
    Application.get_env(:ja_study_tools, JaStudyTools.ElasticsearchCluster)[:url]
  end

  defp parse_search_response
end
