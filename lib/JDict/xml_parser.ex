defmodule JStudyBlog.JDict.XMLParser do
  @behaviour JStudyBlog.JDict.DictionaryParser
  import SweetXml

  @impl JStudyBlog.JDict.DictionaryParser
  def parse_kanji(kanji_stream) do
    kanji_stream
    |> stream_tags([:character], discard: [:character])
    |> Stream.map(fn
     {_, entry} ->
        %{
          character: entry |> xpath(~x"./literal/text()"s),
          stroke_count: entry |> xpath(~x"./misc/stroke_count/text()"i),
          jlpt_level: entry |> xpath(~x"./misc/jlpt/text()"s),
          grade: entry |> xpath(~x"./misc/grade/text()"s),
          meanings: entry|> xpath(~x"./reading_meaning/rmgroup/meaning[not(@*)]/text()"ls),
          onyomi: entry |> xpath(~x"./reading_meaning/rmgroup/reading[@r_type='ja_on']/text()"ls),
          kunyomi: entry |> xpath(~x"./reading_meaning/rmgroup/reading[@r_type='ja_kun']/text()"ls),
        }
    end)
  end

  @impl JStudyBlog.JDict.DictionaryParser
  def parse_vocab(vocab_stream) do
    vocab_stream
    |> stream_tags([:entry], discard: [:entry])
    |> Stream.map(fn
     {_, entry} ->
        %{
          kanji_readings: entry |> xpath(~x"./k_ele/keb/text()"ls),
          kana_readings: entry |> xpath(~x"./r_ele/reb/text()"ls),
          meanings: entry|> xpath(~x"./sense/gloss/text()"ls),
          parts_of_speech: entry |> xpath(~x"./sense/pos/text()"ls)
        }
      end)
  end
end
