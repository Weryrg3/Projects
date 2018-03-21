defmodule Chat2.Managenment do
  def manager_clients(pid_names, names_pid, main_pid_manager, pid_server_manager) do
    receive do
      {:main_user, main_pid, pid_server} ->
        send(main_pid, {:msg, "Usuário principal"})
        manager_clients(pid_names, names_pid, main_pid, pid_server)

      {:new_client, name, pid} ->
        pid_names = Map.put(pid_names, name, pid)
        names_pid = Map.put(names_pid, pid, name)
        manager_clients(pid_names, names_pid, main_pid_manager, pid_server_manager)
    end
  end
end
