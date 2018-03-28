defmodule Novo.Application do
  use Application

  def start(_type, args) do
    children = [
      {Novo.Thing1Supervisor, args}
    ]

    opts = [strategy: :rest_for_one, name: Novo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
