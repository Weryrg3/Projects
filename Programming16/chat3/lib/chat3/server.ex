defmodule Chat3.Server do
  use GenServer
  alias Chat3.ServerImpl

  def init(pid_manager) do
    {:ok, %{pid_manager: pid_manager}}
  end

  def handle_call(:show, _from, map) do
    {:reply, map, map}
  end

  def handle_cast({:new, new_user, pid_user}, map) do
    new_map = ServerImpl.new_user(new_user, pid_user, map)

    send(map.pid_manager, {:new_user, new_map})
    {:noreply, new_map}
  end
end
