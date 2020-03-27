defmodule Mix.Tasks.Dict.ImportTest do
  use ExUnit.Case
  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.VocabMeaning
  alias JStudyBlog.Dictionary.PartOfSpeech
  alias JStudyBlog.JDict.VocabEntry
  alias Mix.Tasks.Dict.Import

  describe "entry_to_vocabs/1" do
    test "entries with multiple kebs creates vocab with alternate_kanji" do
      entry = %VocabEntry{
        kanji_readings: ["keb1", "keb2", "keb3"],
        kana_readings: ["kana1", "kana2", "kana3"],
        meanings: ["meaning1", "meaning2", "meaning3"],
      }
  
      assert Mix.Tasks.Dict.Import.entry_to_vocabs(entry) == [
        %Vocab{
          kanji: "keb1",
          kana: "kana1",
          alternate_kanji: [
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
  end

  test "entries with multiple rebs and no kebs" do
    entry = %VocabEntry{
      kanji_readings: [],
      kana_readings: ["kana1", "kana2", "kana3"],
      meanings: ["meaning1"]
    }

    assert Mix.Tasks.Dict.Import.entry_to_vocabs(entry) == [
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
