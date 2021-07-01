# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ja_study_tools,
  ecto_repos: [JaStudyTools.Repo]

# Configures the endpoint
config :ja_study_tools, JaStudyToolsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Zcd56DfGC9h1OBjUKv8JzjLxQ11bxUxAdLDWkwEszm/YGhZEPTR3+VxhWjtOtVb9",
  render_errors: [view: JaStudyToolsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: JaStudyTools.PubSub,
  live_view: [signing_salt: "Nl88NLgb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ja_study_tools, :pow,
  user: JaStudyTools.Accounts.User,
  repo: JaStudyTools.Repo

config :ja_study_tools, JaStudyTools.ElasticsearchCluster,
  url: "http://elastic:9200"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
