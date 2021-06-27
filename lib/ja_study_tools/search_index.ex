defmodule JaStudyTools.SearchIndex do
  @spec insert_searchable_terms ::
          {:error, %HTTPoison.Error{__exception__: true, id: nil, reason: any}}
          | {:ok,
             %{
               :__struct__ =>
                 HTTPoison.AsyncResponse | HTTPoison.MaybeRedirect | HTTPoison.Response,
               optional(:body) => any,
               optional(:headers) => list,
               optional(:id) => reference,
               optional(:redirect_url) => any,
               optional(:request) => %HTTPoison.Request{
                 body: any,
                 headers: any,
                 method: :delete | :get | :head | :options | :patch | :post | :put,
                 options: any,
                 params: any,
                 url: binary
               },
               optional(:request_url) => any,
               optional(:status_code) => integer
             }}
  def insert_searchable_terms() do
    HTTPoison.post Application.get_env(:ja_study_tools, JaStudyTools.ElasticsearchCluster)[:url], "{\"body\": \"test\"}", [{"Content-Type", "application/json"}]
  end

  def search_terms() do
  end
end
