# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :turbo_phoenix,
  ecto_repos: [TurboPhoenix.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :turbo_phoenix, TurboPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nZaWnN6w8+NKoQl7hDyCkcajpHZwWs0vOyXy4k36I9xAAG8YzqVPG82VNPxtM1Nr",
  render_errors: [view: TurboPhoenixWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: TurboPhoenix.PubSub,
  live_view: [signing_salt: "I8+T7vIpAbuVDbMCheC/i2+s8krfodgb"]

config :turbo_phoenix, TurboPhoenix.Mailer,
  adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
