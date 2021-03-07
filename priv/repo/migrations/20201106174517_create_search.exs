defmodule JaStudyTools.Repo.Migrations.CreateSearch do
  use Ecto.Migration

  def change do
    create table(:searches) do
      add :english_text, :text
      add :japanese_text, :text

      add :vocab_id, references(:vocab)
      add :kanji_id, references(:kanji)

      timestamps(null: true)
    end

    create index(:searches, ["english_text", "japanese_text"], using: "pgroonga")
  end
end
