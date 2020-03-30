defmodule Mix.Tasks.JDict.ImportTest do
  use JStudyBlog.DataCase
  import JStudyBlog.Factory

  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.VocabMeaning
  alias JStudyBlog.Dictionary.PartOfSpeech
  alias JStudyBlog.JDict.VocabEntry
  alias Mix.Tasks.JDict.Import
  alias JStudyBlog.Repo

  describe "entry_to_vocabs/1" do
    test "entries with multiple kebs creates vocab with alternate_readings" do
      entry = %VocabEntry{
        kanji_readings: ["keb1", "keb2", "keb3"],
        kana_readings: ["kana1", "kana2", "kana3"],
        meanings: ["meaning1", "meaning2", "meaning3"],
      }
  
      assert Mix.Tasks.JDict.Import.entry_to_vocabs(entry) == [
        %Vocab{
          kanji: "keb1",
          kana: "kana1",
          alternate_readings: [
            %Vocab {
              kanji: "keb2",
              kana: "kana2"
            },
            %Vocab {
              kanji: "keb3",
              kana: "kana3"
            }
          ],
          meanings: [
            %VocabMeaning{
              definition: "meaning1",
              language: "en-us"
            },
            %VocabMeaning{
              definition: "meaning2",
              language: "en-us"
            },
            %VocabMeaning{
              definition: "meaning3",
              language: "en-us"
            }
          ]
        }
      ]
    end

    test "entries with multiple rebs and no kebs" do
      entry = %VocabEntry{
        kanji_readings: [],
        kana_readings: ["kana1", "kana2", "kana3"],
        meanings: ["meaning1"]
      }

      assert Mix.Tasks.JDict.Import.entry_to_vocabs(entry) == [
        %Vocab{
          kanji: "",
          kana: "kana1",
          meanings: [
            %VocabMeaning{
              definition: "meaning1",
              language: "en-us"
            }
          ]
        },
        %Vocab{
          kanji: "",
          kana: "kana2",
          meanings: [
          %VocabMeaning{
              definition: "meaning1",
              language: "en-us"
            }
          ]
        },
        %Vocab{
          kanji: "",
          kana: "kana3",
          meanings: [
            %VocabMeaning{
              definition: "meaning1",
              language: "en-us"
            }
        ]
        }
      ]
    end
  end

  describe "insert_entry/1" do
    test "vocab is created from the entry elements" do
      entry = %VocabEntry{
        kanji_readings: ["somekanji_11"],
        kana_readings: ["somekana_11"],
        meanings: ["meaning1", "meaning2"]
      }

      Mix.Tasks.JDict.Import.insert_entry(entry)
      inserted = Repo.get_by(Vocab, [kanji: "somekanji_11", kana: "somekana_11"])
                |> Repo.preload([:meanings])
      assert %{
        kanji: "somekanji_11",
        kana: "somekana_11",
        meanings: [
          %{
            definition: "meaning1"
          },
          %{
            definition: "meaning2"
          }
        ]
      } = inserted
    end

    test "multiple kanji_readings are inserted as alternate_readings" do
      entry = %VocabEntry{
        kanji_readings: ["somekanji_1", "somekanji_2", "somekanji_3"],
        kana_readings: ["kana1", "kana2", "kana3"],
        meanings: ["meaning"]
      }

      Mix.Tasks.JDict.Import.insert_entry(entry)
      inserted = Repo.get_by(Vocab, [kanji: "somekanji_1"])
                |> Repo.preload([:meanings, :alternate_readings])

      assert %{
        kanji: "somekanji_1",
        kana: "kana1",
        meanings: [
          %{
            definition: "meaning"
          }
        ],
        alternate_readings: [
          %{
            kanji: "somekanji_2",
            kana: "kana2"
          },
          %{
            kanji: "somekanji_3",
            kana: "kana3"
          }
        ]
      } = inserted
    end

    test "parts of speech are inserted only once" do
      entry = %VocabEntry {
                kanji_readings: ["some kanji", "some kanji"],
                kana_readings: ["some kana", "some kanji"],
                meanings: ["meaning1"],
                parts_of_speech: ["noun", "noun", "i-adj"]
              }

      Mix.Tasks.JDict.Import.insert_entry(entry)
      result = Repo.all(PartOfSpeech, code: "noun")

      assert length(result) == 2
    end

    test "parts of speech are associated with each vocab" do
      entry = %VocabEntry {
                kanji_readings: ["some kanji", "some kanji2"],
                kana_readings: ["some kana", "some kana2"],
                meanings: ["meaning1"],
                parts_of_speech: ["noun", "i-adj"]
              }

      Mix.Tasks.JDict.Import.insert_entry(entry)
      inserted = Repo.get_by(Vocab, kanji: "some kanji")
               |> Repo.preload([:parts_of_speech])
      
      assert %{
        kanji: "some kanji",
        kana: "some kana",
        parts_of_speech: [
          %{
            code: "noun"
          },
          %{
            code: "i-adj"
          }
        ]
      } = inserted
    end
  end

  test "something" do
    v = build(:vocab_parts_of_speech)

    assert %{kanji: "some kanji", parts_of_speech: [pos]} = v
    assert %{code: "n"} = pos
  end
end
