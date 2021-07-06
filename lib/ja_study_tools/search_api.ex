defmodule JaStudyTools.SearchAPI do
  @type indexed_vocab :: %{
    term: String.t(),
    reading: String.t(),
    meanings: [String.t()],
    parts_of_speech: [String.t()]
  }

  @type search_response :: %{
    page: integer(),
    total_pages: integer(),
    vocab: [indexed_vocab()]
  }

  def insert_vocab_searchable(vocab) do
    client().post(base_url() <> "/ja_study_vocab/_bulk", vocab_bulk_insert_params(vocab), [{"Content-Type", "application/json"}])
  end

  @spec search_vocab(any, any) :: {:error, String.t()} | {:ok, %{terms: list, total: any, total_pages: any}}
  def search_vocab(query, page) do
    req_body = vocab_search_params(query, page)

    case client().post(base_url() <> "/ja_study_vocab/_search", req_body, [{"Content-Type", "application/json"}]) do
      {:ok, res} -> {:ok, parse_vocab_search_response(res)}
      {:error, _} -> {:error, "Unable to perform search, please contact administrator if issue persists."}
    end
  end

  defp vocab_search_params(search_by, page) do
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

  defp vocab_bulk_insert_params(vocab) do
    Enum.reduce(vocab, "", fn v, acc ->
      meanings = Enum.join(v.meanings, "\", \"")
      parts_of_speech = Enum.join(v.parts_of_speech, "\", \"")
      acc <> """
       {"index":{"_index":"ja_study_vocab", "_id": "#{v.id}"}}
       {"term": "#{v.term}", "reading": "#{v.reading}", "meanings": ["#{meanings}"], "parts_of_speech": ["#{parts_of_speech}"]}
      """
    end)
  end

  @spec client() :: JaStudyTools.Utils.HTTPClientBehavior
  defp client() do
    Application.get_env(:ja_study_tools, JaStudyTools.HTTP)[:client]
  end

  defp base_url() do
    Application.get_env(:ja_study_tools, JaStudyTools.ElasticsearchCluster)[:url]
  end

  defp parse_vocab_search_response(res) do
    IO.inspect res.body
    decoded = Jason.decode!(res.body)
    %{
      terms: Enum.map(decoded["hits"]["hits"], fn hit ->
        %{
          id: hit["_source"]["_id"],
          term: hit["_source"]["term"],
          reading: hit["_source"]["reading"],
          meanings: hit["_source"]["meanings"],
          parts_of_speech: hit["_source"]["parts_of_speech"],
        }

      end),
      total: decoded["hits"]["total"]["value"],
      total_pages: decoded["hits"]["total"]["value"]
    }
  end
end
