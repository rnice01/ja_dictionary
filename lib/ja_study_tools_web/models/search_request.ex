defmodule JaStudyToolsWeb.Models.SearchRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "params for search request" do
    field :term, :string
    field :page, :integer, default: 1
    field :limit, :integer, default: 25
  end

  @required [:term]
  @optional [:page, :limit]

  def validate(params) do
    changeset = cast(%JaStudyToolsWeb.Models.SearchRequest{}, params, @required ++ @optional)
    |> validate_required(@required)
    |> validate_number(:limit, less_than_or_equal_to: 250)

    case changeset.errors do
      [] -> {:ok, Map.merge(changeset.data, changeset.changes)}
      _ -> {:error, JaStudyTools.Utils.EctoHelpers.changeset_error_to_string(changeset)}
    end
  end
end