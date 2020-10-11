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
  @callback parse_kanji(Stream.t) :: Stream.t([kanji_entry])

  @type vocab_entry :: %{
   kanji_readings: list(String.t),
   kana_readings: list(String.t),
   meanings: list(String.t),
   parts_of_speech: list(String.t)
  }
  @callback parse_vocab(Stream.t) :: Stream.t([vocab_entry])

end
