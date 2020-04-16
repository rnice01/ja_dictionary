defmodule JStudyBlog.Repo.Migrations.CreateVocabs do
  use Ecto.Migration

  def change do
    create table(:vocabs) do
      add :kanji_reading, :string
      add :kana_reading, :string
      add :parts_of_speech, {:array, :string}
      add :meanings, {:array, :string}
      add :primary_kanji_id, references(:vocabs, on_delete: :nothing)

      timestamps()
    end

    create index(:vocabs, [:kanji_reading, :kana_reading, :primary_kanji_id])
    create index(:vocabs, [:meanings], [using: "GIN"])
  end
end
