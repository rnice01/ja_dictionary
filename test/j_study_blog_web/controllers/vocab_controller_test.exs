defmodule JStudyBlogWeb.VocabControllerTest do
  use JStudyBlogWeb.ConnCase

  alias JStudyBlog.Dictionary
  alias JStudyBlog.Dictionary.Vocab

  @create_attrs %{
    kana: "some kana",
    kanji: "some kanji"
  }
  @update_attrs %{
    kana: "some updated kana",
    kanji: "some updated kanji"
  }
  @invalid_attrs %{kana: nil, kanji: nil}

  def fixture(:vocab) do
    {:ok, vocab} = Dictionary.create_vocab(@create_attrs)
    vocab
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vocabs", %{conn: conn} do
      conn = get(conn, Routes.vocab_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vocab" do
    test "renders vocab when data is valid", %{conn: conn} do
      conn = post(conn, Routes.vocab_path(conn, :create), vocab: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.vocab_path(conn, :show, id))

      assert %{
               "id" => id,
               "kana" => "some kana",
               "kanji" => "some kanji"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.vocab_path(conn, :create), vocab: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vocab" do
    setup [:create_vocab]

    test "renders vocab when data is valid", %{conn: conn, vocab: %Vocab{id: id} = vocab} do
      conn = put(conn, Routes.vocab_path(conn, :update, vocab), vocab: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.vocab_path(conn, :show, id))

      assert %{
               "id" => id,
               "kana" => "some updated kana",
               "kanji" => "some updated kanji"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, vocab: vocab} do
      conn = put(conn, Routes.vocab_path(conn, :update, vocab), vocab: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vocab" do
    setup [:create_vocab]

    test "deletes chosen vocab", %{conn: conn, vocab: vocab} do
      conn = delete(conn, Routes.vocab_path(conn, :delete, vocab))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.vocab_path(conn, :show, vocab))
      end
    end
  end

  defp create_vocab(_) do
    vocab = fixture(:vocab)
    {:ok, vocab: vocab}
  end
end
