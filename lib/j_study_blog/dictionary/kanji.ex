defmodule JStudyBlog.Dictionary.Kanji do
  use Ecto.Schema
  import Ecto.Changeset

  schema "kanji" do
    field :character, :string
    field :grade, :string
    field :jlpt_level, :string
    field :kunyomi, {:array, :string}
    field :meanings, {:array, :string}
    field :onyomi, {:array, :string}
    field :stroke_count, :integer
    many_to_many :vocabs, JStudyBlog.Dictionary.Vocab, join_through: "vocab_kanji"

    timestamps()
  end

  @doc false
  def changeset(kanji, attrs) do
    kanji
    |> cast(attrs, [:character, :meanings, :jlpt_level, :grade, :stroke_count, :onyomi, :kunyomi])
    |> validate_required([:character, :meanings, :jlpt_level, :grade, :stroke_count, :onyomi, :kunyomi])
  end
end
