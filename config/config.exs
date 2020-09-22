# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :transaction_agent,
  ecto_repos: [TransactionAgent.Repo]

# Configures the endpoint
config :transaction_agent, TransactionAgentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hQEuZE9w3Htx8wsKLD9nP3kuVoF7JZWX9RSK3O4pBzlH9Cwr0z2+GhH5SvEJ6oXK",
  render_errors: [view: TransactionAgentWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TransactionAgent.PubSub,
  live_view: [signing_salt: "xVZof6MD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
