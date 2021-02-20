defmodule JaStudyTools.JDicts.DictParser do
  @type kanji_entry :: %{
    character: String.t,
    jlpt_level: Integer.t,
    grade: String.t,
    stroke_count: Integer.t,
    meanings: list(String.t),
    onyomi: list(String.t),
    kunyomi: list(String.t)
  }
  @callback stream_kanji(Stream.t) :: Stream.t([kanji_entry])
  @callback read_kanji(binary) :: [kanji_entry]

  @type alternate_reading :: %{
    kanji: String.t,
    kana: String.t
  }
  @type vocab_entry :: %{
   kanji: String.t,
   kana: String.t,
   meanings: list(String.t),
   parts_of_speech: list(String.t),
   alternate_reading: list(alternate_reading)
  }
  @callback stream_vocab(Stream.t) :: Stream.t([vocab_entry])
  @callback read_vocab(binary) :: [vocab_entry]

end
