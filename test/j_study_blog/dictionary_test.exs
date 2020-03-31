defmodule JStudyBlog.DictionaryTest do
  use JStudyBlog.DataCase

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
end
