defmodule JStudyBlogWeb.VocabControllerTest do
  use JStudyBlogWeb.ConnCase
  import JStudyBlog.Factory

  alias JStudyBlog.Dictionary
  alias JStudyBlog.Dictionary.Vocab

  describe "search" do
    test "lists the matching vocabs", %{conn: conn} do
      match1 = build(:vocab_with_parts_of_speech, kanji_reading: "kanji")
      match2 = build(:vocab_with_parts_of_speech, kanji_reading: "kanji")


      conn = post(conn, Routes.vocab_path(conn, :search), %{"kanji" => "kanji"})

      assert html_response(conn, 200) =~ match1.kanji_reading
    end
  end
end
