defmodule JaStudyTools.JDicts.XMLParserTest do
  alias JaStudyTools.JDicts.XMLParser
  use ExUnit.Case

  def kanji_test_stream do
    {:ok, stream} =
    """
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
     """
    |> StringIO.open()

    stream |> IO.stream(:line)
  end

  describe "parse_kanji" do
    test "parsing a character from the kanjidic2" do
      kanji = XMLParser.parse_kanji(kanji_test_stream()) |> Enum.to_list()

      assert kanji == [%{
        character: "楽",
        stroke_count: 15,
        jlpt_level: "2",
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
      ]}]
    end
  end

  def vocab_test_stream do
    {:ok, stream} =
    """
    <entry>
      <ent_seq>1232870</ent_seq>
      <k_ele>
        <keb>許す</keb>
        <ke_pri>ichi1</ke_pri>
        <ke_pri>news1</ke_pri>
        <ke_pri>nf04</ke_pri>
      </k_ele>
      <k_ele>
        <keb>赦す</keb>
      </k_ele>
      <k_ele>
        <keb>聴す</keb>
      </k_ele>
      <r_ele>
        <reb>ゆるす</reb>
        <re_pri>ichi1</re_pri>
        <re_pri>news1</re_pri>
        <re_pri>nf04</re_pri>
      </r_ele>
      <sense>
        <pos>v5s</pos>
        <pos>vt</pos>
        <gloss>to permit</gloss>
        <gloss>to allow</gloss>
        <gloss>to approve</gloss>
        <gloss>to consent to</gloss>
      </sense>
      <sense>
        <gloss>to forgive</gloss>
        <gloss>to pardon</gloss>
        <gloss>to excuse</gloss>
        <gloss>to tolerate</gloss>
      </sense>
    </entry>
    """
    |> StringIO.open()

    stream |> IO.stream(:line)
  end

  describe "parse_vocab" do
    test "parsing an entry from the j_dict" do
      vocab = XMLParser.parse_vocab(vocab_test_stream()) |> Enum.to_list()

      assert vocab == [%{
        kanji_readings: ["許す", "赦す", "聴す"],
        kana_readings: ["ゆるす"],
        parts_of_speech: ["v5s", "vt"],
        meanings: [
        "to permit",
        "to allow",
        "to approve",
        "to consent to",
        "to forgive",
        "to pardon",
        "to excuse",
        "to tolerate"
      ]}]
    end
  end
end
