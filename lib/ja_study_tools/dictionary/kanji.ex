defmodule JaStudyTools.Dictionary.Kanji do
  use Ecto.Schema
  import Ecto.Changeset

  schema "kanji" do
    field :character, :string
    field :grade, :string
    field :jlpt_level, :integer
    field :kunyomi, {:array, :string}
    field :meanings, {:array, :string}
    field :onyomi, {:array, :string}
    field :stroke_count, :integer
    has_one :searchable, JaStudyTools.Dictionary.Search

    many_to_many :vocab, JaStudyTools.Dictionary.Vocab, join_through: "vocab_kanjis"
    timestamps()
  end

  @doc false
  def changeset(kanji, attrs) do
    kanji
    |> cast(attrs, [:character, :kunyomi, :onyomi, :meanings, :stroke_count, :jlpt_level, :grade])
    |> validate_required([:character, :kunyomi, :onyomi, :meanings, :stroke_count, :jlpt_level, :grade])
  end
end
