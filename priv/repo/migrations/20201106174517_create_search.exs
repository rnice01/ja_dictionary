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

    execute "CREATE EXTENSION pg_trgm;"
    execute "CREATE INDEX english_text_trgm_index ON searches USING gin (english_text gin_trgm_ops);"
    execute "CREATE INDEX japanese_text_trgm_index ON searches USING gin (japanese_text gin_trgm_ops);"

    create index(:searches, ["english_text", "japanese_text"], unique: false)
  end
end
