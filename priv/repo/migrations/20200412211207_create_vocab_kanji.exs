defmodule JStudyBlog.Repo.Migrations.CreateVocabKanji do
  use Ecto.Migration

  def change do
    create table(:vocab_kanji) do
      add :vocab_id, references(:vocabs, on_delete: :nothing)
      add :kanji_id, references(:kanji, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:vocab_kanji, [:vocab_id, :kanji_id])
  end
end
