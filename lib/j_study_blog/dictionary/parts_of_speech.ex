defmodule JStudyBlog.Dictionary.PartsOfSpeech do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parts_of_speech" do
    field :code, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(parts_of_speech, attrs) do
    parts_of_speech
    |> cast(attrs, [:code, :description])
    |> validate_required([:code, :description])
  end
end
