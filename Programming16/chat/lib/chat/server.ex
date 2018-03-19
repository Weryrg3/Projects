defmodule Chat.Server do
  alias Chat.{Message}
  @time 2000
  def register(user, server, main_pid) do
    # novo processo self()
    send(server, {:register, self(), user, main_pid})
    Process.monitor(self())
    Message.recebe_mensagens()
  end

  def iniciar_server do
    # user_name -> pid, pid -> user_name
    spawn(__MODULE__, :server_loop, [%{}, %{}])
  end

  def server_loop(user_names, pid_names) do
    receive do
      {:register, pid, user_name, main_pid} ->
        if Map.has_key?(user_names, user_name) do
          send(main_pid, :already_exits)
          server_loop(user_names, pid_names)
        else
          send(main_pid, :continue)
          peoples = length(Map.keys(user_names)) + 1

          user_names
          |> Map.values()
          |> Enum.each(fn pid -> send(pid, {:new_user, user_name, peoples}) end)

          user_names = Map.put(user_names, user_name, pid)
          pid_names = Map.put(pid_names, pid, user_name)
          Process.monitor(pid)
          server_loop(user_names, pid_names)
        end

      {_, _, _, pid_error, :noconnection} ->
        peoples = length(Map.keys(user_names)) - 1

        user_names
        |> Map.values()
        |> Enum.each(fn pid ->
          if pid != pid_error do
            send(pid, {:exit, pid_names[pid_error], peoples})
          end
        end)

        server_loop(
          Map.delete(user_names, pid_names[pid_error]),
          Map.delete(pid_names, pid_error)
        )

      {:msg_server, msg, who?, user_pid} ->
        if String.upcase(who?) == "TODOS" do
          user_names
          |> Map.values()
          |> Enum.each(fn pid ->
            if pid != user_pid do
              send(pid, {:msg, pid_names[user_pid], msg, "todos"})
            end
          end)

          server_loop(user_names, pid_names)
        else
          if user_names[who?] do
            send(user_names[who?], {:msg, pid_names[user_pid], msg, "você"})
            server_loop(user_names, pid_names)
          else
            send(user_pid, {:not_found, who?})
            server_loop(user_names, pid_names)
          end
        end
    after
      @time ->
        server_loop(user_names, pid_names)
    end
  end
end
