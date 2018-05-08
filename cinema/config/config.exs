# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cinema,
  ecto_repos: [Cinema.Repo]

# Configures the endpoint
config :cinema, Cinema.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "E3vSNNHC/SctOoIOG41P1ZwoNsE9uIaNKhPQ1k6gubTFmsuxgwQ6ZJMRCsCPSwbS",
  render_errors: [view: Cinema.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cinema.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
