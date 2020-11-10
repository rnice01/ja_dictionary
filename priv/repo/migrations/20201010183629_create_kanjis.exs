defmodule JaStudyTools.Repo.Migrations.CreateKanjis do
  use Ecto.Migration

  def change do
    create table(:kanji) do
      add :character, :string
      add :kunyomi, {:array, :string}, default: [""]
      add :onyomi, {:array, :string}, default: [""]
      add :meanings, {:array, :"varchar(500)"}, default: [""]
      add :stroke_count, :integer
      add :jlpt_level, :integer
      add :grade, :string

      timestamps(null: true)
    end

  end
end
