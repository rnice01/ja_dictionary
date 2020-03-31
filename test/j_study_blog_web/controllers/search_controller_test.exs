defmodule JStudyBlogWeb.SearchControllerTest do
  use JStudyBlogWeb.ConnCase
  import JStudyBlog.Factory

  alias JStudyBlog.Dictionary
  alias JStudyBlogWeb.Helpers

  describe "searching by kanji" do
    test "returns a list of vocabs with matching kanji readings" do
      vocab1 = build(:vocab_with_parts_of_speech, %{kanji: "matchthis_111fjjfjf"})
      vocab2 = build(:vocab_with_parts_of_speech, %{kanji: "fjskdfjf_matchthis_fjjf323`"})
      vocab3 = build(:vocab_with_parts_of_speech, %{kanji: "shouldnotmatch"})

      conn = post(conn, Routes.search_path(conn, :index), %{kanji: "matchthis"})

      assert json_response(conn, 200)["data"] == %{
        "vocabs" => [
          Helpers.vocab_to_json_map(vocab1),
          Helpers.vocab_to_json_map(vocab2),
        ]
      }
    end
  end
end
