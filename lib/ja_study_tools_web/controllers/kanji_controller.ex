defmodule JaStudyToolsWeb.API.KanjiController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, %{"offset" => offset, "limit" => limit}) do
    case try_parse_offset_limit(offset, limit) do
      {:ok, off, lim} when lim > 500 ->
        {:api_error, :bad_request, "Limit cannot exceed 500"}
      {:ok, off, lim} ->
        kanjis = Dictionary.list_kanjis(off, lim)
        render(conn, "list.json", kanjis: kanjis, next: Routes.kanji_path(conn, :index, offset: off + lim, limit: limit))
      {:error, message} -> {:api_error, :bad_request, message}
    end
  end

  def index(conn, %{"limit" => limit}) do
    index(conn, %{"offset" => 0, "limit" => limit})
  end

  def index(conn, %{"offset" => offset}) do
    index(conn, %{"offset" => offset, "limit" => 25})
  end

  def index(conn, _params) do
    kanjis = Dictionary.list_kanjis(0, 25)
    render(conn, "list.json", kanjis: kanjis, next: Routes.kanji_path(conn, :index, offset: 25, limit: 25))
  end

  def show(conn, %{"id" => id}) do
    kanji = Dictionary.get_kanji!(id)
    render(conn, "show.json", kanji: kanji)
  end

  defp try_parse_limit(result = {:ok, _}, limit) when is_integer(limit), do: Tuple.append(result, limit)

  defp try_parse_limit(result = {:ok, _}, limit) do
    result =
      case Integer.parse(limit) do
        {limit_int, _} -> Tuple.append(result, limit_int)
        :error -> {:error, "Invalid integer value for limit"}
      end

      result
  end

  defp try_parse_limit(result, limit), do: result

  defp try_parse_offset_limit(offset, limit) when is_integer(offset), do: try_parse_limit({:ok, offset}, limit)

  defp try_parse_offset_limit(offset, limit) do
    result =
      case Integer.parse(offset) do
        {offset_int, _} -> {:ok, offset_int}
        :error -> {:error, "Invalid integer value for offset"}
      end
    result
    |> try_parse_limit(limit)
  end
end
