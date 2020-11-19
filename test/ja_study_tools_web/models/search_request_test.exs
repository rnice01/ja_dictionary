defmodule JaStudyToolsWeb.Models.SearchRequestTest do
  alias JaStudyToolsWeb.Models.SearchRequest

  use JaStudyTools.DataCase

  defp invalid_params do
    %{term: ""}
  end

  describe "validation" do
    test "it is invalid without a term" do
      result = SearchRequest.validate(invalid_params())

      assert result == {:error, "term: can't be blank\n"} 
    end

    test "it sets default offset if missing from params" do
      result = SearchRequest.validate(%{term: "test1", limit: 250})

      assert result == {:ok, %JaStudyToolsWeb.Models.SearchRequest{term: "test1", page: 1, limit: 250}}
    end

    test "it sets a default limit if missing from params" do
      result = SearchRequest.validate(%{term: "test2", page: 200})

      assert result == {:ok, %JaStudyToolsWeb.Models.SearchRequest{term: "test2", page: 200, limit: 25}}
    end

    test "it is invalid if limit exceeds 250" do
      result = SearchRequest.validate(%{term: "test2", limit: 500, page: 1})

      assert result == {:error, "limit: must be less than or equal to 250\n"}
    end
  end
end