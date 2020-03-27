defmodule JStudyBlog.Repo.Migrations.CreateVocabPartsOfSpeech do
  use Ecto.Migration

  def change do
    create table(:vocab_parts_of_speech) do
      add :vocab_id, references(:vocabs, on_delete: :nothing)
      add :parts_of_speech_id, references(:parts_of_speech, on_delete: :nothing)

      timestamps()
    end

    create index(:vocab_parts_of_speech, [:vocab_id])
    create index(:vocab_parts_of_speech, [:parts_of_speech_id])
  end
end
