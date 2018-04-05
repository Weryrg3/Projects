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
    {:ok, %{names_pid: %{}, pid_names: %{}}}
  end

  def handle_call(:show, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:new_client, name, pid}, state) do
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
    |> Enum.random()
    |> send({:new_number, number})

    {:noreply, state}
  end

  def handle_info({:register, name, pid, pid_sender}, state) do
    if Map.has_key?(state.names_pid, name) do
      send(pid, {:already_exits, name})
      send(pid_sender, :try_again)
    else
      server = :global.whereis_name(MainServer)
      send(server, {:new_client, name, pid})
      send(pid_sender, :continue)
    end

    {:noreply, state}
  end
end
