defmodule JaStudyToolsWeb.KanjiController do
  use JaStudyToolsWeb, :controller

  alias JaStudyTools.Dictionary
  alias JaStudyTools.Dictionary.Kanji

  action_fallback JaStudyToolsWeb.FallbackController

  def index(conn, %{"offset" => offset, "limit" => limit}) do
    case try_parse_offset_limit(offset, limit) do
      {:ok, off, lim} ->
        kanjis = Dictionary.list_kanjis(off, lim)
        render(conn, "list.json", kanjis: kanjis, next: Routes.kanji_path(conn, :index, offset: off + lim, limit: limit))
      {:error, message} -> send_resp(conn, :error, message)
    end
  end

  def index(conn, _params) do
    kanjis = Dictionary.list_kanjis(0, 25)
    render(conn, "list.json", kanjis: kanjis, next: Routes.kanji_path(conn, :index, offset: 25, limit: 25))
  end

  def create(conn, %{"kanji" => kanji_params}) do
    with {:ok, %Kanji{} = kanji} <- Dictionary.create_kanji(kanji_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.kanji_path(conn, :show, kanji))
      |> render("show.json", kanji: kanji)
    end
  end

  def show(conn, %{"id" => id}) do
    kanji = Dictionary.get_kanji!(id)
    render(conn, "show.json", kanji: kanji)
  end

  def update(conn, %{"id" => id, "kanji" => kanji_params}) do
    kanji = Dictionary.get_kanji!(id)

    with {:ok, %Kanji{} = kanji} <- Dictionary.update_kanji(kanji, kanji_params) do
      render(conn, "show.json", kanji: kanji)
    end
  end

  def delete(conn, %{"id" => id}) do
    kanji = Dictionary.get_kanji!(id)

    with {:ok, %Kanji{}} <- Dictionary.delete_kanji(kanji) do
      send_resp(conn, :no_content, "")
    end
  end

  defp try_parse_limit(result = {:ok, _}, limit) do
    result =
      if {limit_int, _} = Integer.parse(limit) do
        Tuple.append(result, limit_int)
      else
        {:err, "Invalid integer value for limit"}
      end
  end

  defp try_parse_limit(result, limit), do: result

  defp try_parse_offset_limit(offset, limit) do
    result =
      if {offset_int, _} = Integer.parse(offset) do
        {:ok, offset_int}
      else
        {:err, "Invalid integer value for offset or limit"}
      end

    result
    |> try_parse_limit(limit)
  end
end
