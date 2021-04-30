# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :anais,
  ecto_repos: [Anais.Repo]

# Configures the endpoint
config :anais, AnaisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dTKwiLhCG9L9U8+TimxtUXfa1hHth9+KK/19y5v53RRI0ffLx3yttMqSa1O6/FXe",
  render_errors: [view: AnaisWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Anais.PubSub,
  live_view: [signing_salt: "um+zQT8q"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :anais, Anais.Guardian,
       issuer: "anais",
       secret_key: "j8Cs3mBK4AbWaz6Pki0w4R0ZR6S6IzUGCNZC/AQUx1jhKvS8qZwn+H2g3xw1HxJv"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
