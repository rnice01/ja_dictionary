defmodule Mix.Tasks.JDict.ImportTest do
  use JStudyBlog.DataCase
  import JStudyBlog.Factory

  alias JStudyBlog.Dictionary.Vocab
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
          kanji_reading: "keb1",
          kana_reading: "kana1",
          alternate_readings: [
            %Vocab {
              kanji_reading: "keb2",
              kana_reading: "kana2"
            },
            %Vocab {
              kanji_reading: "keb3",
              kana_reading: "kana3"
            }
          ],
          meanings: ["meaning1", "meaning2", "meaning3"]
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
          kanji_reading: "",
          kana_reading: "kana1",
          meanings: ["meaning1"]
        },
        %Vocab{
          kanji_reading: "",
          kana_reading: "kana2",
          meanings: ["meaning1"]
        },
        %Vocab{
          kanji_reading: "",
          kana_reading: "kana3",
          meanings: ["meaning1"]
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
      assert %{
        kanji_reading: "somekanji_11",
        kana_reading: "somekana_11",
        meanings: ["meaning1", "meaning2"]
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

      assert %{
        kanji_reading: "somekanji_1",
        kana_reading: "kana1",
        meanings: ["meaning"],
        alternate_readings: [
          %{
            kanji_reading: "somekanji_2",
            kana_reading: "kana2"
          },
          %{
            kanji_reading: "somekanji_3",
            kana_reading: "kana3"
          }
        ]
      } = inserted
    end
  end
end
