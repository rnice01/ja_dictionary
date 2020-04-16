defmodule JStudyBlog.JDict.XMLParserTest do
  alias JStudyBlog.JDict.XMLParser
  use ExUnit.Case

  def test_stream do
    {:ok, stream} =
    "
      <character>
        <literal>楽</literal>
      </character>
     "
    |> StringIO.open()

    stream
  end

  describe "parse_kanji" do
    test "it gets the kanji character from the document stream" do
      {:ok, kanji} = XMLParser.parse_kanji(test_stream())

      assert kanji == [%{character: "楽"}]
    end
  end
end
