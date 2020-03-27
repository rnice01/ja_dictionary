defmodule JStudyBlog.Dictionary.PartOfSpeech do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parts_of_speech" do
    field :code, :string
    field :description, :string
    belongs_to :vocab, JStudyBlog.Dictionary.Vocab
    many_to_many :vocabs, JStudyBlog.Dictionary.Vocab, join_through: "vocab_parts_of_speech"
    timestamps()
  end

  @doc false
  def changeset(vocab, attrs) do
    vocab
    |> cast(attrs, [:code, :description])
    |> validate_required([:code, :description])
  end
end
