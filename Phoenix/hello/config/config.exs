use Mix.Config

config :hello, ecto_repos: [Hello.Repo]

config :hello, Hello.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lEGYQZWXmUyPeJ7UXYUOp7MoXf7Uwwr44+5i+yt80ZX2EK0li4AXpsWnJSKhiPFo",
  render_errors: [view: Hello.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hello.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env()}.exs"
