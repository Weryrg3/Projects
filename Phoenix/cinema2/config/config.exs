# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cinema2, ecto_repos: [Cinema2.Repo]

# Configures the endpoint
config :cinema2, Cinema2.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GlyFuTZ3f3diiIGkjjO2+px9HfllLjTmEFLtPmY4YiEHNvVCrQT/eTOYTB9tzAWm",
  render_errors: [view: Cinema2.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cinema2.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# configure new language
config :cinema2, Cinema2.Gettext, default_locale: "pt_BR"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
