defmodule JStudyBlog.DictionaryTest do
  use JStudyBlog.DataCase
  import JStudyBlog.Factory

  alias JStudyBlog.Dictionary

  describe "vocabs" do
    alias JStudyBlog.Dictionary.Vocab

    @valid_attrs %{kana: "some kana", kanji: "some kanji_reading", meanings: [], alternate_readings: [], parts_of_speech: []}
    @update_attrs %{kana: "some kana", kanji: "some updated kanji_reading"}
    @invalid_attrs %{kana: nil, kanji: nil}

    def vocab_fixture(attrs \\ %{}) do
      {:ok, vocab} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dictionary.create_vocab()

      vocab
    end

    test "list_vocabs/0 returns all vocabs" do
      vocab = vocab_fixture()
      assert Dictionary.list_vocabs() == [vocab]
    end

    test "get_vocab!/1 returns the vocab with given id" do
      vocab = vocab_fixture()
      assert Dictionary.get_vocab!(vocab.id) == vocab
    end

    test "create_vocab/1 with valid data creates a vocab" do
      assert {:ok, %Vocab{} = vocab} = Dictionary.create_vocab(@valid_attrs)
      assert vocab.kana == "some kana"
      assert vocab.kanji == "some kanji_reading"
    end

    test "create_vocab/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dictionary.create_vocab(@invalid_attrs)
    end

    test "update_vocab/2 with valid data updates the vocab" do
      vocab = vocab_fixture()
      assert {:ok, %Vocab{} = vocab} = Dictionary.update_vocab(vocab, @update_attrs)
      assert vocab.kana == "some kana"
      assert vocab.kanji == "some updated kanji_reading"
    end

    test "update_vocab/2 with invalid data returns error changeset" do
      vocab = vocab_fixture()
      assert {:error, %Ecto.Changeset{}} = Dictionary.update_vocab(vocab, @invalid_attrs)
      assert vocab == Dictionary.get_vocab!(vocab.id)
    end

    test "delete_vocab/1 deletes the vocab" do
      vocab = vocab_fixture()
      assert {:ok, %Vocab{}} = Dictionary.delete_vocab(vocab)
      assert_raise Ecto.NoResultsError, fn -> Dictionary.get_vocab!(vocab.id) end
    end

    test "change_vocab/1 returns a vocab changeset" do
      vocab = vocab_fixture()
      assert %Ecto.Changeset{} = Dictionary.change_vocab(vocab)
    end
  end

  describe "kanji" do
    alias JStudyBlog.Dictionary.Kanji

    @valid_attrs %{character: "some character", grade: "some grade", jlpt_level: "some jlpt_level", kunyomi: [], meanings: [], onyomi: [], stroke_count: 42}
    @update_attrs %{character: "some updated character", grade: "some updated grade", jlpt_level: "some updated jlpt_level", kunyomi: [], meanings: [], onyomi: [], stroke_count: 43}
    @invalid_attrs %{character: nil, grade: nil, jlpt_level: nil, kunyomi: nil, meanings: nil, onyomi: nil, stroke_count: nil}

    def kanji_fixture(attrs \\ %{}) do
      {:ok, kanji} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dictionary.create_kanji()

      kanji
    end

    test "list_kanji/0 returns all kanji" do
      kanji = kanji_fixture()
      assert Dictionary.list_kanji() == [kanji]
    end

    test "get_kanji!/1 returns the kanji with given id" do
      kanji = kanji_fixture()
      assert Dictionary.get_kanji!(kanji.id) == kanji
    end

    test "create_kanji/1 with valid data creates a kanji" do
      assert {:ok, %Kanji{} = kanji} = Dictionary.create_kanji(@valid_attrs)
      assert kanji.character == "some character"
      assert kanji.grade == "some grade"
      assert kanji.jlpt_level == "some jlpt_level"
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
      assert kanji.jlpt_level == "some updated jlpt_level"
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
