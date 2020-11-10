defmodule JaStudyTools.JDicts.XMLParserTest do
  alias JaStudyTools.JDicts.XMLParser
  use ExUnit.Case

  def kanji_test_stream do
    {:ok, stream} =
    """
    <dict>
      <character>
        <literal>楽</literal>
        <misc>
          <grade>8</grade>
          <stroke_count>15</stroke_count>
          <freq>1395</freq>
          <jlpt>2</jlpt>
        </misc>
        <reading_meaning>
          <rmgroup>
            <reading r_type="korean_h">태</reading>
            <reading r_type="vietnam">Duệ</reading>
            <reading r_type="vietnam">Nhuệ</reading>
            <reading r_type="ja_on">エイ</reading>
            <reading r_type="ja_kun">するど.い</reading>
            <meaning>pointed</meaning>
            <meaning>sharpness</meaning>
            <meaning>edge</meaning>
            <meaning>weapon</meaning>
            <meaning>sharp</meaning>
            <meaning>violent</meaning>
            <meaning m_lang="fr">pointu</meaning>
            </rmgroup>
          </reading_meaning>
      </character>
      <character>
        <literal>楽</literal>
        <misc>
          <grade>7</grade>
          <stroke_count>5</stroke_count>
          <freq>1395</freq>
        </misc>
        <reading_meaning>
          <rmgroup>
            <reading r_type="korean_h">태</reading>
            <reading r_type="vietnam">Duệ</reading>
            <reading r_type="vietnam">Nhuệ</reading>
            <reading r_type="ja_on">エイ</reading>
            <reading r_type="ja_kun">するど.い</reading>
            <meaning>pointed</meaning>
            <meaning m_lang="fr">pointu</meaning>
            </rmgroup>
          </reading_meaning>
      </character>
    </dict>
     """
    |> StringIO.open()

    stream |> IO.stream(:line)
  end

  describe "parse_kanji" do
    test "parsing a character from the kanjidic2" do
      kanji = XMLParser.parse_kanji(kanji_test_stream()) |> Enum.to_list()

      assert kanji == [
        %{
          character: "楽",
          stroke_count: 15,
          jlpt_level: 2,
          grade: "8",
          kunyomi: ["するど.い"],
          onyomi: ["エイ"],
          meanings: [
          "pointed",
          "sharpness",
          "edge",
          "weapon",
          "sharp",
          "violent"
        ]
      },
      %{
        character: "楽",
        stroke_count: 5,
        jlpt_level: 0,
        grade: "7",
        kunyomi: ["するど.い"],
        onyomi: ["エイ"],
        meanings: [
        "pointed",
        ]
      }
    ]
    end
  end

  def vocab_test_stream do
    {:ok, stream} =
    """
    <doc>
    <entry>
      <ent_seq>1000310</ent_seq>
      <k_ele>
        <keb>馬酔木</keb>
      </k_ele>
      <r_ele>
        <reb>あせび</reb>
      </r_ele>
      <r_ele>
        <reb>あしび</reb>
      </r_ele>
      <r_ele>
        <reb>あせぼ</reb>
      </r_ele>
      <r_ele>
        <reb>あせぶ</reb>
      </r_ele>
      <r_ele>
        <reb>アセビ</reb>
        <re_nokanji/>
      </r_ele>
      <sense>
        <pos>n</pos>
        <misc>uk</misc>
        <gloss>Japanese andromeda (Pieris japonica)</gloss>
        <gloss>lily-of-the-valley</gloss>
      </sense>
    </entry>
    <entry>
      <ent_seq>1000320</ent_seq>
      <k_ele>
        <keb>彼処</keb>
        <ke_pri>ichi1</ke_pri>
      </k_ele>
      <k_ele>
        <keb>彼所</keb>
      </k_ele>
      <r_ele>
        <reb>あそこ</reb>
        <re_pri>ichi1</re_pri>
      </r_ele>
      <r_ele>
        <reb>あすこ</reb>
      </r_ele>
      <r_ele>
        <reb>かしこ</reb>
      </r_ele>
      <r_ele>
        <reb>アソコ</reb>
        <re_nokanji/>
      </r_ele>
      <r_ele>
        <reb>あしこ</reb>
        <re_inf>ok</re_inf>
      </r_ele>
      <r_ele>
        <reb>あこ</reb>
        <re_inf>ok</re_inf>
      </r_ele>
      <sense>
        <pos>pn</pos>
        <xref>どこ・1</xref>
        <xref>ここ・1</xref>
        <xref>そこ・1</xref>
        <misc>uk</misc>
        <gloss>there (place physically distant from both speaker and listener)</gloss>
        <gloss>over there</gloss>
        <gloss>that place</gloss>
        <gloss>yonder</gloss>
        <gloss>you-know-where</gloss>
      </sense>
      <sense>
        <stagr>あそこ</stagr>
        <stagr>あすこ</stagr>
        <stagr>アソコ</stagr>
        <pos>n</pos>
        <misc>col</misc>
        <misc>uk</misc>
        <gloss>genitals</gloss>
        <gloss>private parts</gloss>
        <gloss>nether regions</gloss>
      </sense>
      <sense>
        <pos>n</pos>
        <xref>あれほど</xref>
        <misc>uk</misc>
        <gloss>that far (something psychologically distant from both speaker and listener)</gloss>
        <gloss>that much</gloss>
        <gloss>that point</gloss>
      </sense>
    </entry>
    </doc>
    """
    |> StringIO.open()

    stream |> IO.stream(:line)
  end

  describe "parse_vocab" do
    test "parsing an entry from the j_dict" do
      vocab = XMLParser.parse_vocab(vocab_test_stream()) |> Enum.to_list()

      assert vocab == [
        %{
          kanji: "馬酔木",
          kana: "あせび",
          parts_of_speech: ["n"],
          meanings: ["Japanese andromeda (Pieris japonica)", "lily-of-the-valley"],
          alternate_readings: [%{kanji: "馬酔木", kana: "あしび"}, %{kanji: "馬酔木", kana: "あせぼ"}, %{kanji: "馬酔木", kana: "あせぶ"}, %{kanji: "", kana: "アセビ"}]
        },
        %{
          kanji: "彼処",
          kana: "あそこ",
          parts_of_speech: ["pn", "n", "n"],
          meanings: ["there (place physically distant from both speaker and listener)", "over there", "that place", "yonder", "you-know-where", "genitals", "private parts", "nether regions", "that far (something psychologically distant from both speaker and listener)", "that much", "that point"],
          alternate_readings: [
            %{kanji: "彼所", kana: "あすこ"},
            %{kanji: "彼所", kana: "かしこ"},
            %{kanji: "彼所", kana: "あしこ"},
            %{kanji: "彼所", kana: "あこ"},
            %{kanji: "", kana: "アソコ"}
          ]
        }
      ]
    end
  end
end
