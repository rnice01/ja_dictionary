defmodule JaStudyTools.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :username, :string, null: false
      add :role, :string, default: "user"
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
