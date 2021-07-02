defmodule JaStudyTools.Utils.HTTPClientBehavior do
  @type url :: String.t()
  @type body :: String.t()
  @type headers :: []

  @doc """
  Performs a POST request, only returns the unencoded body.
  """
  @callback post(url, body, headers) :: {:ok, String.t()} | {:error, String.t()}
end

defmodule JaStudyTools.Utils.HTTPClient do
  @behaviour JaStudyTools.Utils.HTTPClientBehavior

  @impl JaStudyTools.Utils.HTTPClientBehavior
  def post(url, body, headers \\ []) do
    case HTTPoison.post(url, body, headers) do
      {:ok, res} -> {:ok, res.body}
      {:error, err} -> {:error, err.message}
    end
  end
end
