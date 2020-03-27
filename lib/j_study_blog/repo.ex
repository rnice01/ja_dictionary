defmodule JStudyBlog.Repo do
  use Ecto.Repo,
    otp_app: :j_study_blog,
    adapter: Ecto.Adapters.Postgres
end
