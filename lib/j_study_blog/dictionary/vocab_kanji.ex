defmodule JStudyBlog.Dictionary.VocabKanji do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vocab_kanji" do
    field :vocab_id, :id
    field :kanji_id, :id

    timestamps()
  end

  @doc false
  def changeset(vocab_kanji, attrs) do
    vocab_kanji
    |> cast(attrs, [])
    |> validate_required([])
  end
end
