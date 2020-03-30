defmodule JStudyBlogWeb.VocabView do
  use JStudyBlogWeb, :view
  alias JStudyBlogWeb.VocabView

  def render("index.json", %{vocabs: vocabs}) do
    %{data: render_many(vocabs, VocabView, "vocab.json")}
  end

  def render("show.json", %{vocab: vocab}) do
    %{data: render_one(vocab, VocabView, "vocab.json")}
  end

  def render("vocab.json", %{vocab: vocab}) do
    %{id: vocab.id,
      kanji: vocab.kanji,
      kana: vocab.kana,
      meanings: Enum.map(vocab.meanings, fn %{definition: d, language: l} -> %{definition: d, language: l} end),
      alternate_readings: Enum.map(vocab.alternate_readings, fn %{kanji: kj, kana: ka} -> %{kanji: kj, kana: ka} end),
      parts_of_speech: Enum.map(vocab.parts_of_speech, fn pos -> %{code: pos.code, description: pos.description} end)
    }
  end
end
