defmodule JStudyBlog.Factory do
  use ExMachina.Ecto, repo: JStudyBlog.Repo
  alias JStudyBlog.Dictionary.Vocab
  alias JStudyBlog.Dictionary.Kanji

  def vocab_factory(attrs) do
    %Vocab{
      kanji_reading: Map.get(attrs, :kanji, "some kanji"),
      kana_reading: Map.get(attrs, :kana, "some kana"),
      meanings: Map.get(attrs, :meanings, [ "meaning1", "meaning2"]),
      parts_of_speech: Map.get(attrs, :parts_of_speech, ["noun", "suru verb"])
    }
  end

  def kanji_factory(attrs) do
    %Kanji{
      character: Map.get(attrs, :character, "冬"),
      grade: Map.get(attrs, :grade, "1"),
      jlpt_level: Map.get(attrs, :jlpt_level, "N5"),
      kunyomi: Map.get(attrs, :kunyomi, ["ふゆ"]),
      meanings: Map.get(attrs, :meanings, ["winter"]),
      onyomi: Map.get(attrs, :onyomi, ["とう"]),
      stroke_count: Map.get(attrs, :stroke_count, 8)
    }
  end
end
