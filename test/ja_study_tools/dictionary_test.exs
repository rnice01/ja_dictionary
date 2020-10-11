defmodule JaStudyTools.DictionaryTest do
  use JaStudyTools.DataCase

  alias JaStudyTools.Dictionary

  describe "kanjis" do
    alias JaStudyTools.Dictionary.Kanji

    @valid_attrs %{character: "some character", grade: "some grade", jlpt_level: 42, kunyomi: [], meanings: [], onyomi: [], stroke_count: 42}
    @update_attrs %{character: "some updated character", grade: "some updated grade", jlpt_level: 43, kunyomi: [], meanings: [], onyomi: [], stroke_count: 43}
    @invalid_attrs %{character: nil, grade: nil, jlpt_level: nil, kunyomi: nil, meanings: nil, onyomi: nil, stroke_count: nil}

    def kanji_fixture(attrs \\ %{}) do
      {:ok, kanji} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dictionary.create_kanji()

      kanji
    end

    test "get_kanji!/1 returns the kanji with given id" do
      kanji = kanji_fixture()
      assert Dictionary.get_kanji!(kanji.id) == kanji
    end

    test "create_kanji/1 with valid data creates a kanji" do
      assert {:ok, %Kanji{} = kanji} = Dictionary.create_kanji(@valid_attrs)
      assert kanji.character == "some character"
      assert kanji.grade == "some grade"
      assert kanji.jlpt_level == 42
      assert kanji.kunyomi == []
      assert kanji.meanings == []
      assert kanji.onyomi == []
      assert kanji.stroke_count == 42
    end

    test "create_kanji/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dictionary.create_kanji(@invalid_attrs)
    end

    test "update_kanji/2 with valid data updates the kanji" do
      kanji = kanji_fixture()
      assert {:ok, %Kanji{} = kanji} = Dictionary.update_kanji(kanji, @update_attrs)
      assert kanji.character == "some updated character"
      assert kanji.grade == "some updated grade"
      assert kanji.jlpt_level == 43
      assert kanji.kunyomi == []
      assert kanji.meanings == []
      assert kanji.onyomi == []
      assert kanji.stroke_count == 43
    end

    test "update_kanji/2 with invalid data returns error changeset" do
      kanji = kanji_fixture()
      assert {:error, %Ecto.Changeset{}} = Dictionary.update_kanji(kanji, @invalid_attrs)
      assert kanji == Dictionary.get_kanji!(kanji.id)
    end

    test "delete_kanji/1 deletes the kanji" do
      kanji = kanji_fixture()
      assert {:ok, %Kanji{}} = Dictionary.delete_kanji(kanji)
      assert_raise Ecto.NoResultsError, fn -> Dictionary.get_kanji!(kanji.id) end
    end

    test "change_kanji/1 returns a kanji changeset" do
      kanji = kanji_fixture()
      assert %Ecto.Changeset{} = Dictionary.change_kanji(kanji)
    end
  end
end
