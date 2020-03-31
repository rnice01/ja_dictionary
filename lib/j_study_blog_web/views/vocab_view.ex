defmodule JStudyBlogWeb.VocabView do
  use JStudyBlogWeb, :view
  alias JStudyBlogWeb.VocabView
  alias JStudyBlogWeb.Helpers

  def render("index.json", %{vocabs: vocabs}) do
    %{data: render_many(vocabs, VocabView, "vocab.json")}
  end

  def render("show.json", %{vocab: vocab}) do
    %{data: render_one(vocab, VocabView, "vocab.json")}
  end

  def render("vocab.json", %{vocab: vocab}) do
    Helpers.vocab_to_json_map(vocab)
  end
end
