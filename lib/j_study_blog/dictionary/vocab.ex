defmodule JStudyBlog.Dictionary.Vocab do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %JStudyBlog.Dictionary.Vocab{
      kana_reading: String.t,
      kanji_reading: String.t,
      meanings: list(String.t),
      parts_of_speech: list(String.t),
      alternate_readings: %{kana: String.t, kanji: String.t},
      kanji: list(JStudyBlog.Dictionary.Kanji.t)
    }

  schema "vocabs" do
    field :kana_reading, :string
    field :kanji_reading, :string
    field :parts_of_speech, { :array, :string }
    field :meanings, { :array, :string }
    belongs_to :primary_kanji, JStudyBlog.Dictionary.Vocab
    has_many :alternate_readings, JStudyBlog.Dictionary.Vocab, foreign_key: :primary_kanji_id
    many_to_many :kanji, JStudyBlog.Dictionary.Kanji, join_through: "vocab_kanji"

    timestamps()
  end

  @doc false
  def changeset(vocab, attrs) do
    vocab
    |> cast(attrs, [:kanji_reading, :kana_reading, :parts_of_speech, :meanings])
    |> validate_required([:kana_reading, :parts_of_speech, :meanings])
  end
end
