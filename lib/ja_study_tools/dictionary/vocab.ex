defmodule JaStudyTools.Dictionary.Vocab do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vocab" do
    field :term, :string
    field :reading, :string
    field :meanings, {:array, :string}
    field :parts_of_speech, {:array, :string}
    has_one :searchable, JaStudyTools.Dictionary.Search

    many_to_many :kanji, JaStudyTools.Dictionary.Kanji, join_through: "vocab_kanjis"
    timestamps()
  end

  @doc false
  def changeset(vocab, attrs) do
    vocab
    |> cast(attrs, [:term, :reading, :meanings, :parts_of_speech])
    |> validate_required([:term, :reading, :meanings, :parts_of_speech])
  end

end
