defmodule JaStudyTools.DictionaryTest do
  use JaStudyTools.DataCase
  import JaStudyTools.Testing.Factory

  alias JaStudyTools.Dictionary

  describe "finding kanji" do
    test "finding kanji by vocab word" do
      insert(:kanji, character: "綺")
      insert(:kanji, character: "麗")

      result = Dictionary.find_kanji_by_characters("綺麗") 
      |> Enum.reduce([], fn k, res -> 
        res ++ [k.character]
      end)

      assert result == ["綺", "麗"]
    end
  end
end
