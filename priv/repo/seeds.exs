# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     JaStudyTools.Repo.insert!(%JaStudyTools.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

JaStudyTools.Accounts.create_admin(%{username: "admin", email: "admin@email.com", password: "supersecret", password_confirmation: "supersecret"})
