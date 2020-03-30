defmodule JStudyBlogWeb.VocabControllerTest do
  use JStudyBlogWeb.ConnCase
  import JStudyBlog.Factory

  alias JStudyBlog.Dictionary
  alias JStudyBlog.Dictionary.Vocab

  describe "index" do
    test "lists all vocabs", %{conn: conn} do
      vocab = build(:vocab_with_parts_of_speech)

      conn = get(conn, Routes.vocab_path(conn, :index))

      assert [%{
        "id" => vocab.id,
        "kanji" => vocab.kanji,
        "kana" => vocab.kana,
        "meanings" => Enum.map(vocab.meanings, fn vm -> %{"definition" => vm.definition, "language" => vm.language} end),
        "alternate_readings" => Enum.map(vocab.alternate_readings, fn ar -> %{"kanji" => ar.kanji, "kana" => ar.kana} end),
        "parts_of_speech" => Enum.map(vocab.parts_of_speech, fn pos -> %{"code" => pos.code, "description" => pos.description} end)
      }] == json_response(conn, 200)["data"]
    end
  end
end
