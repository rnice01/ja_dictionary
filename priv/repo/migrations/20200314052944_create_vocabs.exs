defmodule JStudyBlog.Repo.Migrations.CreateVocabs do
  use Ecto.Migration

  def change do
    create table(:vocabs) do
      add :kanji, :string
      add :kana, :string
      add :primary_kanji_id, references(:vocabs, on_delete: :nothing)

      timestamps()
    end

    create index(:vocabs, [:kanji, :kana, :primary_kanji_id])
  end
end
