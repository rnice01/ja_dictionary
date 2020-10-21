{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(JaStudyTools.Repo, :manual)

defmodule JaStudyTools.Testing.WebHelpers do
  def assign_user(user, conn) do
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :ja_study_tools)

    conn
  end
end
