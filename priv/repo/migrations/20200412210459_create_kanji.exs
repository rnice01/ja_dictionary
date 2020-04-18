defmodule JStudyBlog.Repo.Migrations.CreateKanji do
  use Ecto.Migration

  def change do
    create table(:kanji) do
      add :character, :string
      add :meanings, {:array, :string}
      add :jlpt_level, :string
      add :grade, :string
      add :stroke_count, :integer
      add :onyomi, {:array, :string}
      add :kunyomi, {:array, :string}

      timestamps(null: true)
    end

    create index(:kanji, [:character, :jlpt_level])
    create index(:kanji, [:meanings, :onyomi, :kunyomi], [using: "GIN"])
  end
end
