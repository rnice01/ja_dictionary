defmodule JaStudyTools.Dictionary.Search do
  use Ecto.Schema
  import Ecto.Changeset

  schema "searches" do
    field :english_text, :string
    field :japanese_text, :string

    belongs_to :vocab, JaStudyTools.Dictionary.Vocab
    belongs_to :kanji, JaStudyTools.Dictionary.Kanji
    timestamps()
  end

  @doc false
  def changeset(search, attrs) do
    search
    |> cast(attrs, [:english_text, :japanese_text])
    |> validate_required([:english_text, :japanese_text])
  end

end
