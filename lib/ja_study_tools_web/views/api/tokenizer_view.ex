defmodule JaStudyToolsWeb.API.TokenizerView do
  use JaStudyToolsWeb, :view
  alias JaStudyToolsWeb.API.TokenizerView

  def render("index.json", %{results: results}) do
    %{data: %{text: results.text}}
  end
end
