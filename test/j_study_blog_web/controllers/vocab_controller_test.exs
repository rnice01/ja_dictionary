defmodule JStudyBlogWeb.VocabControllerTest do
  use JStudyBlogWeb.ConnCase
  import JStudyBlog.Factory

  alias JStudyBlog.Dictionary
  alias JStudyBlog.Dictionary.Vocab

  #setup %{conn: conn} do
  #  {:ok, conn: put_req_header(conn, "accept", "text/html")}
 # end

  describe "index" do
    test "lists all vocabs", %{conn: conn} do
      vocab = insert(:vocab)
      conn = get(conn, Routes.vocab_path(conn, :index))
      IO.inspect json_response(conn, 200)["data"]
      assert json_response(conn, 200)["data"] == [%{
        id: vocab.id,
        kanji: vocab.kanji,
        kana: vocab.kana,
        meanings: Enum.map(vocab.meanings, fn vm -> %{definition: vm.definition, language: vm.language} end),
        alternate_readings: Enum.map(vocab.alternate_readings, fn ar -> %{kanji: ar.kanji, kana: ar.kana} end)
      }]
    end
  end
end
