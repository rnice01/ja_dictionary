defmodule JaStudyTools.JDicts.YomichanParserTest do
  alias JaStudyTools.JDicts.YomichanParser
  use ExUnit.Case

  def kanji_test_file do
  end

  describe "parse_kanji" do
    test "parsing a character from the kanjidic2" do
      path = Path.expand("../support/fixtures/kanji_defs.json", __DIR__)

      kanji = YomichanParser.read_kanji(File.read!(path))

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
end
