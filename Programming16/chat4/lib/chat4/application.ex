defmodule Chat4.Application do
  use Application

  def start(_type, _args) do
    children = [
      Chat4.MasterSupervisor
    ]

    opts = [strategy: :one_for_one, name: Chat4.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
