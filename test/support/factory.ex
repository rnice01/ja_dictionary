defmodule JStudyBlog.Factory do
  use ExMachina.Ecto, repo: JStudyBlog.Repo
  alias JStudyBlog.Dictionary.Vocab

  def vocab_factory(attrs) do
    %Vocab{
      kanji_reading: Map.get(attrs, :kanji, "some kanji"),
      kana_reading: Map.get(attrs, :kana, "some kana"),
      meanings: [ "meaning1", "meaning2"],
      parts_of_speech: ["noun", "suru verb"]
    }
  end
end
