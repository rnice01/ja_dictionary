defmodule JStudyBlog.Dictionary.PartOfSpeech do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parts_of_speech" do
    field :code, :string
    field :description, :string
    many_to_many :vocabs, JStudyBlog.Dictionary.Vocab, join_through: VocabPartsOfSpeech
    timestamps()
  end

  @doc false
  def changeset(vocab, attrs) do
    vocab
    |> cast(attrs, [:code, :description])
    |> validate_required([:code, :description])
  end
end
