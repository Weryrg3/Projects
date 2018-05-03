defmodule Example do
  use Application
  # require Logger

  def start(_type, _args) do
    port = Application.get_env(:example, :comboy_port, 8080)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http,
      Example.Router, [], port: port)
    ]


    Supervisor.start_link(children,
    strategy: :one_for_one)
  end
end
