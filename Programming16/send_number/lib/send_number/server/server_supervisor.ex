defmodule SendNumber.Server.ServerSupervisor do
  use Supervisor
  alias SendNumber.Server.MainServer

  def start_link(_arg) do
    Supervisor.start_link(__MODULE__, [], name: ServerSupervisor)
  end

  def init(_arg) do
    Supervisor.init([MainServer], strategy: :one_for_one)
  end
end
