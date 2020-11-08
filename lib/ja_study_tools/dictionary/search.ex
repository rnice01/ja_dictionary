defmodule TSVectorType do
  @behaviour Ecto.Type

  def type, do: :tsvector

  def cast(tsvector), do: {:ok, tsvector}
  def load(tsvector), do: {:ok, tsvector}
  def dump(tsvector), do: {:ok, tsvector}
  def embed_as(tsvector), do: {:ok, tsvector}
end

defmodule JaStudyTools.Dictionary.Search do
  use Ecto.Schema
  import Ecto.Changeset

  schema "searches" do
    field :english_text, :string
    field :japanese_text, :string
    field :english_tsv, TSVectorType
    field :japanese_tsv, TSVectorType

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
