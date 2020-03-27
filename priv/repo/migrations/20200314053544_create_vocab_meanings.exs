defmodule JStudyBlog.Repo.Migrations.CreateVocabMeanings do
  use Ecto.Migration

  def change do
    create table(:vocab_meanings) do
      add :definition, :text
      add :language, :string
      add :vocab_id, references(:vocabs, on_delete: :nothing)

      timestamps()
    end

    create index(:vocab_meanings, [:vocab_id, :definition])
  end
end
