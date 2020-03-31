defmodule JStudyBlog.Dictionary.VocabMeaning do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %JStudyBlog.Dictionary.VocabMeaning{language: String.t, definition: String.t}

  schema "vocab_meanings" do
    field :language, :string
    field :definition, :string
    belongs_to :vocab, JStudyBlog.Dictionary.Vocab

    timestamps()
  end

  @doc false
  def changeset(vocab_meaning, attrs) do
    vocab_meaning
    |> cast(attrs, [:definition, :language])
    |> validate_required([:definition, :language])
  end
end
