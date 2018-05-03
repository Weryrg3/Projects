defmodule SendNumber.Clients.ReceiveNumbers do
  use GenServer

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  def init(_arg) do
    {:ok, %{number: 0, last_number: 0}}
  end

  def handle_info({:last_number, new_last_number}, state) do
    state = Map.update!(state, :last_number, fn _ -> new_last_number end)
    send(state.send, {:last_number, new_last_number})
    {:noreply, state}
  end

  def handle_info({:gen_message, message}, state) do
    IO.puts(message)
    {:noreply, state}
  end

  def handle_info({:send_pid, pid_sender}, state) do
    {:noreply, Map.put(state, :send, pid_sender)}
  end

  def handle_info({:name, name}, state) do
    IO.puts("Seu nome escolhido foi #{name}")
    IO.puts("Bem vindo #{name}")
    {:noreply, state}
  end

  def handle_info({:new_number, number, name}, state) do
    IO.puts("Você recebeu um número do(a) #{name}")
    IO.puts("Número recebido #{number}\n")

    if state.number + 1 == number do
      IO.puts("##############################################")
      IO.puts("#################################            #")
      IO.puts("##      Adicionando número")
      IO.puts("##    Número no status: #{number} / #{state.last_number}")
      IO.puts("#################################            #")
      IO.puts("##############################################\n")
      send(state.send, :next)

      state = Map.update!(state, :number, fn _old_number -> number end)

      if state.number == state.last_number do
        IO.puts("##################################")
        IO.puts("#           Parabéns             #")
        IO.puts("# Você recebeu o último número   #")
        IO.puts("#            Saindo              #")
        IO.puts("##################################")
        Process.sleep(3000)
        IO.puts("###")
        Process.sleep(2000)
        IO.puts("##")
        Process.sleep(1000)
        IO.puts("#")
        System.halt()
      else
        {:noreply, state}
      end
    else
      IO.puts("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
      IO.puts("XX         Número negado")
      IO.puts("XX      Número no status: #{state.number} / #{state.last_number}")
      IO.puts("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n")
      send(state.send, :next)
      {:noreply, state}
    end
  end
end

