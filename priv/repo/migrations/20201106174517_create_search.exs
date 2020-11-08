defmodule JaStudyTools.Repo.Migrations.CreateSearch do
  use Ecto.Migration

  def change do
    create table(:searches) do
      add :english_text, :text
      add :japanese_text, :text
      add :english_tsv, :tsvector
      add :japanese_tsv, :tsvector

      add :vocab_id, references(:vocab)
      add :kanji_id, references(:kanji)

      timestamps(null: true)
    end

    #execute "CREATE EXTENSION pg_trgm;"
    #execute "CREATE INDEX english_text_trgm_index ON searches USING gin (english_tsv gin_trgm_ops);"
    #execute "CREATE INDEX japanese_text_trgm_index ON searches USING gin (japanese_tsv gin_trgm_ops);"

    create index(:searches, ["english_tsv", "japanese_tsv"], using: "GIN")

    execute"""
    CREATE OR REPLACE FUNCTION search_text_to_tsv() RETURNS trigger AS $$
    BEGIN
      new.english_tsv = to_tsvector('english', new.english_text);
      new.english_text = '';
      new.japanese_tsv = to_tsvector('simple', new.japanese_text);
      new.japanese_text = '';
      return new;
    END
    $$ language plpgsql;
    """

    execute"""
     CREATE TRIGGER search_text_tsv BEFORE INSERT OR UPDATE
      ON searches FOR EACH ROW EXECUTE PROCEDURE search_text_to_tsv();
    """
  end

  def down do
    execute"""
     DROP TRIGGER search_text_tsv ON searches;
    """
    execute"""
     DROP FUNCTION search_text_to_tsv;
    """
  end
end
