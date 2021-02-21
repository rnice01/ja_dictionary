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
  @callback read_kanji(binary) :: [kanji_entry]

  @type vocab_entry :: %{
   term: String.t,
   reading: String.t,
   meanings: list(String.t),
   parts_of_speech: list(String.t),
  }
  @callback read_vocab(binary) :: [vocab_entry]

end
