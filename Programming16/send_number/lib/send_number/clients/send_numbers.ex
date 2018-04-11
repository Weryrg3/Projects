defmodule SendNumber.Clients.SendNumbers do
  alias SendNumber.Clients.{ReceiveNumbers, RandomName}
  use GenServer
  @me __MODULE__

  def start_link(num) do
    {:ok, pid_receive} = ReceiveNumbers.start_link([])
    start(pid_receive, num)
  end

  def init(state) do
    {:ok, state}
  end

  defp start(pid_receive, num) do
    name = RandomName.names()
    main_server = :global.whereis_name(MainServer)

    send(main_server, {:register, name, pid_receive, self(), num})

    receive do
      :try_again ->
        start(pid_receive, num)

      {:continue, numero} ->
        {:ok, pid_self} =
          GenServer.start_link(
            __MODULE__,
            %{
              pid_receive: pid_receive,
              main_server: main_server,
              name: name,
              number: numero
            },
            name: @me
          )

        send(pid_receive, {:name, name})
        send(pid_receive, {:send_pid, pid_self})
        send(pid_receive, {:last_number, numero})
        GenServer.cast(@me, :server)
    end
  end

  def handle_cast(:server, state) do
    Process.monitor(state.main_server)
    send(@me, :next)
    {:noreply, state}
  end

  def handle_info(:next, state) do
    number = Enum.random(1..state.number)
    Process.sleep(2000)
    send(state.pid_receive, {:gen_message, "Enviando número: #{number}\n"})
    send(state.main_server, {:new_number, number, state.pid_receive})

    {:noreply, state}
  end

  def handle_info({:DOWN, _, :process, _, :noconnection}, state) do
    new_connection = :global.whereis_name(MainServer)

    new_server = new_server(state.main_server, new_connection)

    send(new_server, {:register, state.name, state.pid_receive, self(), state.number})
    state = Map.update!(state, :main_server, fn _ -> new_server end)
    {:noreply, state}
  end

  def handle_info({:continue, number}, state) do
    GenServer.cast(@me, :server)
    state = Map.update!(state, :number, fn _ -> number end)
    {:noreply, state}
  end

  def handle_info({:last_number, new_last_number}, state) do
    state = Map.update!(state, :number, fn _ -> new_last_number end)
    {:noreply, state}
  end

  # recebeu new server :undefinido
  def new_server(old_server, new_server) do
    case new_server do
      ^old_server ->
        IO.puts("Falha ao conectar")
        new_server = :global.whereis_name(MainServer)
        new_server(old_server, new_server)

      :undefined ->
        IO.puts("Falha ao conectar")
        IO.puts("Servidor não encontrado\n")
        Process.sleep(1000)
        new_server = :global.whereis_name(MainServer)
        new_server(old_server, new_server)

      anyone ->
        IO.puts("Reconectando ao novo servidor")
        anyone
    end
  end
end
