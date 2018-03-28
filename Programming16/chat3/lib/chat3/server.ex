defmodule Chat3.Server do
  use GenServer

  @server {:global, Server}

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @server)
  end

  def init(:no_args) do
    {:ok, %{}}
  end

  def handle_call(:show,_from, map) do
    {:reply, map, map}
  end

  def handle_cast({:new, new_user, pid_user}, map) do
    map =
      map
      |> Map.put(new_user, pid_user)
      |> Map.put(pid_user, new_user)

    {:noreply, map}
  end
end

