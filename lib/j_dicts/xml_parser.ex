defmodule JaStudyTools.JDicts.XMLParser do
  import SweetXml

  def parse_kanji(kanji_stream) do
    kanji_stream
    |> stream_tags([:character], discard: [:character])
    |> Stream.map(fn
     {_, entry} ->
        %{
          character: entry |> xpath(~x"./literal/text()"S),
          stroke_count: entry |> xpath(~x"./misc/stroke_count/text()"I),
          jlpt_level: entry |> xpath(~x"./misc/jlpt/text()"I),
          grade: entry |> xpath(~x"./misc/grade/text()"S),
          meanings: entry|> xpath(~x"./reading_meaning/rmgroup/meaning[not(@*)]/text()"ls),
          onyomi: entry |> xpath(~x"./reading_meaning/rmgroup/reading[@r_type='ja_on']/text()"ls),
          kunyomi: entry |> xpath(~x"./reading_meaning/rmgroup/reading[@r_type='ja_kun']/text()"ls),
        }
    end)
  end

  def parse_vocab(vocab_stream) do
    vocab_stream
    |> stream_tags([:entry], discard: [:entry])
    |> Stream.map(fn
     {_, entry} ->
      entry
      |> xpath(~x"//k_ele"le)
      |> parse_vocab_element(entry)
      |> Map.put(:meanings, entry |> xpath(~x"./sense/gloss/text()"ls))
      |> Map.put(:parts_of_speech, entry |> xpath(~x"./sense/pos/text()"ls) |> Enum.uniq)
      end)
  end

  def parse_vocab_element(k_ele, entry) when length(k_ele) > 1 do
    kanji = entry |> xpath(~x"./k_ele[ke_pri]/keb/text()"S)
    alt_kanji = entry |> xpath(~x"./k_ele[not(ke_pri)]/keb/text()"ls)

    kana = entry |> xpath(~x"./r_ele[re_pri]/reb/text()"S)

    alternate_readings = entry |> xpath(~x"./r_ele[not(re_nokanji) and not(re_pri)]/reb/text()"ls)
    |> Enum.with_index
    |> Enum.map(fn {kana, i} ->
      %{
        kanji: Enum.at(alt_kanji, i, Enum.at(alt_kanji, 0)),
        kana: kana
      }
    end)

    no_kanji_readings = entry |> xpath(~x"./r_ele[re_nokanji]/reb/text()"ls) |> Enum.map(fn kana -> %{ kanji: "", kana: kana } end)

    %{
      kanji: kanji,
      kana: kana,
      alternate_readings: alternate_readings ++ no_kanji_readings
    }
  end

  def parse_vocab_element(k_ele, entry) do
    kanji = entry |> xpath(~x"./k_ele/keb/text()"s)
    [kana | alternate_kana] = case entry |> xpath(~x"./r_ele[not(re_nokanji)]/reb/text()"ls) do
      [] -> ["", ""]
      readings -> readings
    end

    alternate_readings = alternate_kana |> Enum.map(fn kana -> %{ kanji: kanji, kana: kana } end)
    no_kanji_readings = entry |> xpath(~x"./r_ele[re_nokanji]/reb/text()"ls) |> Enum.map(fn kana -> %{ kanji: "", kana: kana } end)

    vocab = %{
      kanji: kanji,
      kana: kana,
      alternate_readings: alternate_readings ++ no_kanji_readings
    }
  end

  def read_kanji(_) do end
  def read_vocab(_) do end
end
