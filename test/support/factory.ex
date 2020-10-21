defmodule JaStudyTools.Testing.Factory do
  use ExMachina.Ecto, repo: JaStudyTools.Repo

  def kanji_factory do
    %JaStudyTools.Dictionary.Kanji{
      character: "冬",
      grade: "1",
      jlpt_level: 5,
      kunyomi: ["ふゆ"],
      onyomi: ["とう"],
      meanings: ["winter"],
      stroke_count: 5
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
