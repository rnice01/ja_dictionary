defmodule JaStudyTools.Repo.Migrations.CreateVocab do
  use Ecto.Migration

  def change do
    create table(:vocab) do
      add :kanji_reading, :string
      add :kana, :string
      add :meanings, {:array, :"varchar(500)"}, default: [""]
      add :parts_of_speech, {:array, :string}, default: [""]
      add :alternate_readings, {:array, :map}, default: []

      timestamps(null: true)
    end

  end
end
