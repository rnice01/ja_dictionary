defmodule JaStudyTools.Repo.Migrations.CreateVocab do
  use Ecto.Migration

  def change do
    create table(:vocab) do
      add :term, :string, default: ""
      add :reading, :string, default: ""
      add :meanings, {:array, :"varchar(500)"}, default: [""]
      add :parts_of_speech, {:array, :string}, default: [""]

      timestamps(null: true)
    end

    #create index(:vocab, ["term", "reading", "meanings"], unique: false, using: "pgroonga")
  end
end
