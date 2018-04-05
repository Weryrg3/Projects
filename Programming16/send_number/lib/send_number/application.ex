defmodule SendNumber.Application do
  @moduledoc false
  alias SendNumber.Server.ServerSupervisor
  use Application

  def start(_type, _args) do
    children = [ServerSupervisor]

    opts = [strategy: :one_for_one, name: SendNumber.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
