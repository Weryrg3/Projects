defmodule Chat4.Client.Printer do
  use GenServer

  def start_link(client) do
    GenServer.start_link(__MODULE__, client)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info({:server_message, message}, state) do
    IO.puts(message)
    {:noreply, state}
  end

  def handle_info({:all, message, name_sender}, state) do
    IO.puts("[#{name_sender}, Todos] - #{message}")
    {:noreply, state}
  end

  def handle_info({:private, message, name_sender}, state) do
    IO.puts("[#{name_sender}, você] - #{message}")
    {:noreply, state}
  end
end
