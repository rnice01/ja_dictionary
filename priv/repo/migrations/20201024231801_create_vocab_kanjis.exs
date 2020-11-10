defmodule JaStudyTools.Repo.Migrations.CreateVocabKanjis do
  use Ecto.Migration

  def change  do
    create table(:vocab_kanjis) do
      add :vocab_id, references(:vocab)
      add :kanji_id, references(:kanji)
    end
    create unique_index(:vocab_kanjis, [:vocab_id, :kanji_id])
  end
end
