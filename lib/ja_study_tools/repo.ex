defmodule JaStudyTools.Repo do
  use Ecto.Repo,
    otp_app: :ja_study_tools,
    adapter: Ecto.Adapters.Postgres
  use Scrivener
end
