defmodule JStudyBlog.Dictionary.VocabPartsOfSpeech do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vocab_parts_of_speech" do
    field :vocab_id, :id
    field :parts_of_speech_id, :id

    timestamps()
  end

  @doc false
  def changeset(vocab_parts_of_speech, attrs) do
    vocab_parts_of_speech
    |> cast(attrs, [])
    |> validate_required([])
  end
end
