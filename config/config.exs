# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :plantar,
  ecto_repos: [Plantar.Repo]

# Configures the endpoint
config :plantar, PlantarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "quBhaZh8GfiP/xWDLbzshQ+3G2hTe9Umdfp1yrWNfglzFHF7raQRHP7kkwtws3ST",
  render_errors: [view: PlantarWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Plantar.PubSub,
  live_view: [signing_salt: "M5wpNv9x"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
