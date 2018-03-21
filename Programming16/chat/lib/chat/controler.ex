defmodule Chat.Controler do
  def controler1(server_pid, list_acc, pids, name_server) do
    if Process.alive?(server_pid) do
      controler1(server_pid, list_acc, pids, name_server)
    else
      remove_server = Map.drop(pids, list_acc)
      clients = Map.drop(pids, Map.keys(remove_server))

      Enum.sort(clients)
      |> Enum.at(0)
      |> (fn {_name, pid} -> send(pid, {:new_server, name_server, clients}) end).()
    end
    receive do
      {:new_user, user, pids} ->
        controler1(server_pid, [user] ++ list_acc, pids, name_server)
    end
  end

  def new_server() do
  end
end
