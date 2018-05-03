defmodule Chat4.Manager do
  use GenServer

  def start_link(manager) do
    # %{client: %{name: name, pid_input: self(), pid_print: pid_print}, server: pid_server}
    GenServer.start_link(__MODULE__, manager)
  end

  def init(manager) do
    {:ok, manager}
  end

  def handle_info({:server, pid_server}, manager) do
    new_server = :global.whereis_name(Chat4.Master)

    manager = Map.update!(manager, :server, fn _old_server -> new_server end)

    unless pid_server == manager.server do
      client = manager.client
      IO.inspect("Reconectando no servidor")

      send(
        client.pid_print,
        {:server_message, "Servidor caiu, pressione Enter para se reconectar"}
      )

      send(client.pid_input, {:new_server, new_server})
      send(new_server, {:reconnect, client})
    end

    {:noreply, manager}
  end
end
