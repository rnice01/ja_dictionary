defmodule JStudyBlog.JDict.DictionaryParser do
  @type kanji_entry :: %{
    character: String.t,
    jlpt_level: String.t,
    grade: String.t,
    stroke_count: Integer.t,
    meanings: list(String.t),
    onyomi: list(String.t),
    kunyomi: list(String.t)
  }
  @callback parse_kanji(Stream.t) :: {:ok, list(kanji_entry)} | {:error, String.t}

  @type vocab_entry :: %{
   kanji_readings: list(String.t),
   kana_readings: list(String.t),
   meanings: list(String.t),
   parts_of_speech: list(String.t)
  }
  @callback parse_vocab(Stream.t) :: {:ok, list(vocab_entry)} | {:error, String.t}

end