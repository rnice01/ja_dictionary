defmodule JaStudyTools.Repo.Migrations.AddPgroongaExtension do
  use Ecto.Migration

  def change do
    execute """
      CREATE EXTENSION pgroonga;
    """
    execute """
      SET enable_seqscan = off;
    """
  end
end
