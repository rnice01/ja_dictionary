defmodule JaStudyTools.Testing.Factory do
  use ExMachina.Ecto, repo: JaStudyTools.Repo

  def kanji_factory(attrs) do
    %JaStudyTools.Dictionary.Kanji{
      character: Map.get(attrs, :character, "冬"),
      grade: "1",
      jlpt_level: 5,
      kunyomi: Map.get(attrs, :kunyomi, ["ふゆ"]),
      onyomi: Map.get(attrs, :onyomi, ["とう"]),
      meanings: Map.get(attrs, :meanings, ["winter"]),
      stroke_count: 5
    }
  end

  def vocab_factory(attrs) do
    %JaStudyTools.Dictionary.Vocab{
      term: Map.get(attrs, :term, "人口"),
      reading: Map.get(attrs, :reading, "じんこう"),
      meanings: Map.get(attrs, :meanings, ["population"]),
      parts_of_speech: Map.get(attrs, :parts_of_speech, ["noun"])
    }
  end

  def admin_factory do
    %JaStudyTools.Accounts.User{
      username: "some admin",
      email: "some_admin@domain.com",
      role: "admin"
    }
  end

  def user_factory do
    %JaStudyTools.Accounts.User{
      username: "some username",
      email: "email@domain.com",
      role: "user"
    }
  end
end
