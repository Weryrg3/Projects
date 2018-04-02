defmodule Chat4.Client.Printer do
  use GenServer

  def start_link(client) do
    GenServer.start_link(__MODULE__, client)
  end

  def init(client) do
    client = Map.put(client, :pid_print, self())
    # Chat4.Manager.start_link(client)
    {:ok, client}
  end

  def handle_info({:server_message, message}, state) do
    IO.puts(message)
    {:noreply, state}
  end

  def handle_info({:all, message, pid_sender}, state) do
    IO.inspect(state)
    IO.puts("[#{pid_sender}] >> #{message}")
    {:noreply, state}
  end

  def handle_info({:manager, message}, state) do # Gerenciador
    send(state, message)
    {:noreply, state}
  end
end
