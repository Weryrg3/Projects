defmodule Chat2.Server do
  # alias Chat2.Server
  def iniciar_server(main_pid, pid_manager) do
    pid_server = spawn(__MODULE__, :server, [pid_manager])
    send(pid_manager, {:main_user, main_pid, pid_server})
  end

  def server(pid_manager) do
    receive do
      {:msg, msg} ->
        
    end
    server(pid_manager)
  end
end
