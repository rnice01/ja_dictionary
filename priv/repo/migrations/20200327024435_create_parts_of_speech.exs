defmodule JStudyBlog.Repo.Migrations.CreatePartsOfSpeech do
  use Ecto.Migration

  def change do
    create table(:parts_of_speech) do
      add :code, :string
      add :description, :string

      timestamps()
    end

  end
end
