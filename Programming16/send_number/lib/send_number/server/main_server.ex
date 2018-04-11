defmodule SendNumber.Server.MainServer do
  use GenServer

  def start_link(arg) do
    server = GenServer.start_link(__MODULE__, arg, name: {:global, MainServer})

    case server do
      {:ok, pid} ->
        {:ok, pid}

      {:error, {:already_started, pid}} ->
        Process.link(pid)
        {:ok, pid}
    end
  end

  def init(_arg) do
    IO.puts("Iniciando servidor")
    {:ok, %{names_pid: %{}, pid_names: %{}, numbers: []}}
  end

  def handle_call(:show, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:new_client, name, pid}, state) do
    Map.keys(state.pid_names)
    |> case do
      [] ->
        ""

      pids ->
        Enum.each(
          pids,
          &send(
            &1,
            {:gen_message, "#{name} entrou na sala\nPessoas onlines: #{length(pids) + 1}\n"}
          )
        )
    end

    state =
      Map.update!(state, :names_pid, fn names_pid ->
        Map.put(names_pid, name, pid)
      end)
      |> Map.update!(:pid_names, fn pid_names ->
        Map.put(pid_names, pid, name)
      end)

    {:noreply, state}
  end

  def handle_info({:new_number, number, exception_pid}, state) do
    Map.keys(state.pid_names)
    |> List.delete(exception_pid)
    |> case do
      [] ->
        send(exception_pid, {:gen_message, ":/ Você está sozinho :("})

      list_pids ->
        new_state = state.pid_names

        Enum.random(list_pids)
        |> send({:new_number, number, Map.get(new_state, exception_pid)})
    end

    {:noreply, state}
  end

  def handle_info({:register, name, pid, pid_sender, num}, state) do
    if Map.has_key?(state.names_pid, name) do
      send(pid, {:already_exits, name})
      send(pid_sender, :try_again)
    else
      # Errro
      server = :global.whereis_name(MainServer)
      maior_numero = Enum.max([num] ++ state.numbers)
      send(server, {:new_client, name, pid})

      Map.keys(state.pid_names)
      |> case do
        [] ->
          ""

        pids ->
          Enum.each(
            pids,
            &send(&1, {:last_number, maior_numero})
          )
      end

      send(pid_sender, {:continue, maior_numero})
    end

    state = Map.update!(state, :numbers, fn numbers -> [num] ++ numbers end)
    {:noreply, state}
  end
end
