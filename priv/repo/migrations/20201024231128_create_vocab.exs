defmodule JaStudyTools.Repo.Migrations.CreateVocab do
  use Ecto.Migration

  def change do
    create table(:vocab) do
      add :kanji_reading, :string, default: ""
      add :kana, :string, default: ""
      add :meanings, {:array, :"varchar(500)"}, default: [""]
      add :parts_of_speech, {:array, :string}, default: [""]
      add :alternate_readings, {:array, :map}, default: []

      timestamps(null: true)
    end

    create index(:vocab, ["kanji_reading", "kana", "alternate_readings"], unique: false)
  end
end
