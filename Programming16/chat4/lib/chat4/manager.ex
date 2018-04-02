defmodule Chat4.Manager do
  use GenServer

  def start_link(client) do
    IO.inspect(client)
    GenServer.start_link(__MODULE__, %{client: client, server: self()})
  end

  def init(manager) do
    {:ok, manager}
  end

  # def handle_info(:require_state, manager) do
  #   IO.inspect(Process.alive?(manager.server))

  #   pid_server = :global.whereis_name(Chat4.Master)
  #   manager = Map.update!(manager, :server, pid_server)

  #   send(pid_server, {:new_state, manager})
  #   {:noreply, manager}
  # end
end
