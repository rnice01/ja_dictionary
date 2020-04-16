defmodule JStudyBlogWeb.KanjiController do
  use JStudyBlogWeb, :controller

  alias JStudyBlog.Dictionary
  alias JStudyBlog.Dictionary.Kanji

  def index(conn, _params) do
    kanji = Dictionary.list_kanji()
    render(conn, "index.html", kanji: kanji)
  end

  def new(conn, _params) do
    changeset = Dictionary.change_kanji(%Kanji{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"kanji" => kanji_params}) do
    case Dictionary.create_kanji(kanji_params) do
      {:ok, kanji} ->
        conn
        |> put_flash(:info, "Kanji created successfully.")
        |> redirect(to: Routes.kanji_path(conn, :show, kanji))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    kanji = Dictionary.get_kanji!(id)
    render(conn, "show.html", kanji: kanji)
  end

  def edit(conn, %{"id" => id}) do
    kanji = Dictionary.get_kanji!(id)
    changeset = Dictionary.change_kanji(kanji)
    render(conn, "edit.html", kanji: kanji, changeset: changeset)
  end

  def update(conn, %{"id" => id, "kanji" => kanji_params}) do
    kanji = Dictionary.get_kanji!(id)

    case Dictionary.update_kanji(kanji, kanji_params) do
      {:ok, kanji} ->
        conn
        |> put_flash(:info, "Kanji updated successfully.")
        |> redirect(to: Routes.kanji_path(conn, :show, kanji))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", kanji: kanji, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    kanji = Dictionary.get_kanji!(id)
    {:ok, _kanji} = Dictionary.delete_kanji(kanji)

    conn
    |> put_flash(:info, "Kanji deleted successfully.")
    |> redirect(to: Routes.kanji_path(conn, :index))
  end
end
