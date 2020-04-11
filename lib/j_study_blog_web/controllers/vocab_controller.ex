defmodule JStudyBlogWeb.VocabController do
  use JStudyBlogWeb, :controller

  alias JStudyBlog.Dictionary
  alias JStudyBlog.Dictionary.Vocab

  action_fallback JStudyBlogWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.html", vocabs: nil)
  end

  def search(conn, %{"kanji" => k}) do
    vocabs = Dictionary.find_vocabs_by(%{kanji: k})

    render(conn, "index.html", vocabs: vocabs)
  end

  def create(conn, %{"vocab" => vocab_params}) do
    with {:ok, %Vocab{} = vocab} <- Dictionary.create_vocab(vocab_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.vocab_path(conn, :show, vocab))
      |> render("show.json", vocab: vocab)
    end
  end

  def show(conn, %{"id" => id}) do
    vocab = Dictionary.get_vocab!(id)
    render(conn, "show.json", vocab: vocab)
  end

  def update(conn, %{"id" => id, "vocab" => vocab_params}) do
    vocab = Dictionary.get_vocab!(id)

    with {:ok, %Vocab{} = vocab} <- Dictionary.update_vocab(vocab, vocab_params) do
      render(conn, "show.json", vocab: vocab)
    end
  end

  def delete(conn, %{"id" => id}) do
    vocab = Dictionary.get_vocab!(id)

    with {:ok, %Vocab{}} <- Dictionary.delete_vocab(vocab) do
      send_resp(conn, :no_content, "")
    end
  end
end
