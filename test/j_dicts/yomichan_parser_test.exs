defmodule JaStudyTools.JDicts.YomichanParserTest do
  alias JaStudyTools.JDicts.YomichanParser
  alias JaStudyTools.Testing.TestHelpers
  use ExUnit.Case

  def kanji_test_file do
  end

  describe "parse_kanji" do
    test "parsing a character from the kanjidic2" do
      test_file = TestHelpers.file_fixture_path("kanji_defs.json") |> File.read!

      kanji = YomichanParser.read_kanji(test_file)

      assert kanji == [
        %{
          character: "秡",
          stroke_count: 10,
          jlpt_level: 0,
          grade: "",
          kunyomi: [],
          onyomi: ["ハツ", "バチ"],
          meanings: [
          "damaged grain"
        ]
      },
      %{
        character: "秣",
        stroke_count: 10,
        jlpt_level: 0,
        grade: "",
        kunyomi: ["まぐさ", "まぐさかう"],
        onyomi: ["マツ", "バツ"],
        meanings: [
        "fodder",
        ]
      },
      %{
        character: "稈",
        stroke_count: 12,
        jlpt_level: 0,
        grade: "",
        kunyomi: ["わら"],
        onyomi: ["カン"],
        meanings: [
          "straw",
          "hollow stem"
        ]
      },
      %{
        character: "稍",
        stroke_count: 12,
        jlpt_level: 0,
        grade: "",
        kunyomi: ["やや", "ようやく"],
        onyomi: ["ソウ", "ショウ"],
        meanings: [
          "slightly"
        ]
      },
      %{
        character: "稘",
        stroke_count: 13,
        jlpt_level: 0,
        grade: "",
        kunyomi: [],
        onyomi: ["キ"],
        meanings: [
          "straw",
          "one year"
        ]
      }
    ]
    end
  end

  describe "read_vocab" do
    test "it correctly parses the vocab file" do
      test_file = TestHelpers.file_fixture_path("vocab_defs.json") |> File.read!

      vocab = YomichanParser.read_vocab(test_file)

      assert vocab == [
        %{
          primary: "ガチャガチャ",
          alternate: "",
          parts_of_speech: ["n"],
          meanings: [
            "capsule toy vending machine"
          ]
        },
        %{
          primary: "ガチャガチャ",
          alternate: "",
          parts_of_speech: ["adj-na", "n", "vs", "adv", "adv-to", "on-mim"],
          meanings: [
            "clatter",
            "clank",
            "rattling"
          ]
        },
        %{
          primary: "かんかん怒る",
          alternate: "かんかんおこる",
          parts_of_speech: ["v5r"],
          meanings: [
            "to get very mad"
          ]
        },
        %{
          primary: "御新香",
          alternate: "おしんこ",
          parts_of_speech: ["n"],
          meanings: [
            "pickled vegetables",
            "pickles"
          ]
        }
      ]
    end
  end
end
