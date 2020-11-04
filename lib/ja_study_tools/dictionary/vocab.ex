defmodule JaStudyTools.Dictionary.Vocab do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vocab" do
    field :kana, :string
    field :kanji_reading, :string
    field :meanings, {:array, :string}
    field :parts_of_speech, {:array, :string}
    embeds_many :alternate_readings, JaStudyTools.Dictionary.VocabAlternateReading

    many_to_many :kanji, JaStudyTools.Dictionary.Kanji, join_through: "vocab_kanjis"
    timestamps()
  end

  @doc false
  def changeset(vocab, attrs) do
    vocab
    |> cast(attrs, [:kanji_reading, :kana, :meanings, :parts_of_speech])
    |> cast_embed(:alternate_readings)
    |> validate_required([:kanji_reading, :kana, :meanings, :parts_of_speech])
  end

end

defmodule JaStudyTools.Dictionary.VocabAlternateReading do
  use Ecto.Schema
  import Ecto.Changeset
  
  embedded_schema do
    field :kanji, :string
    field :kana, :string
  end

  def changeset(alt_reading, attrs) do 
    alt_reading
    |> cast(attrs, [:kanji, :kana])
    |> validate_required([:kanji, :kana])
  end
end