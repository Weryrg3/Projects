defmodule SendNumber.Clients.ReceiveNumbers do
  use GenServer

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  def init(arg) do
    {:ok, %{number: 0, send: arg}}
  end

  def handle_info({:name, name}, state) do
    IO.puts("Seu nome escolhido foi #{name}")
    IO.puts("Bem vindo #{name}")
    {:noreply, state}
  end

  def handle_info({:new_number, number}, state) do
    IO.puts("Número recebido #{number}")
    # pid_server = :global.whereis_name(MainServer)
    if state.number + 1 == number do
      IO.puts("Adicionando número")

      send(state.send, :next)
      {:noreply, Map.update!(state, :number, fn _old_number -> number end)}
    else
      IO.puts("Número ruim")
      send(state.send, :next)
      {:noreply, state}
    end
  end
end
