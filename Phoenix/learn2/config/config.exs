# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :learn2,
  ecto_repos: [Learn2.Repo]

# Configures the endpoint
config :learn2, Learn2.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eP01zu4bX1d2yL/GY1qOUeKY2nwQPJY2NTpZQZlAOnLu28QVfToj0J4hEMVdZrdR",
  render_errors: [view: Learn2.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Learn2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
