defmodule Chat.Server do
  alias Chat.{Message}
  @time 2000
  def register(user, server, main_pid) do
    # novo processo self()
    send(server, {:register, self(), user, main_pid})
    Message.recebe_mensagens()
  end

  def iniciar_server(name_room) do
    # user_name -> pid, pid -> user_name
    spawn(__MODULE__, :server_loop, [%{}, %{}, self(), name_room])
  end

  def server_loop(user_names, pid_names, pid_server, name_room) do
    receive do
      {:register, pid, user_name, main_pid} ->
        if Map.has_key?(user_names, user_name) do
          send(main_pid, :already_exits)
          server_loop(user_names, pid_names, pid_server, name_room)
        else
          send(main_pid, :continue)
          qtd_people = length(Map.keys(user_names)) + 1

          user_names = Map.put(user_names, user_name, pid)
          pid_names = Map.put(pid_names, pid, user_name)

          user_names
          |> Map.values()
          |> Enum.each(fn pids ->
            if pids != pid do
              send(pids, {:new_user, user_name, qtd_people})
            end
          end)

          Process.monitor(pid)
          server_loop(user_names, pid_names, pid_server, name_room)
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
          Map.delete(pid_names, pid_error),
          pid_server,
          name_room
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

          server_loop(user_names, pid_names, pid_server, name_room)
        else
          if user_names[who?] do
            send(user_names[who?], {:msg, pid_names[user_pid], msg, "você"})
            server_loop(user_names, pid_names, pid_server, name_room)
          else
            send(user_pid, {:not_found, who?})
            server_loop(user_names, pid_names, pid_server, name_room)
          end
        end
    after
      @time ->
        server_loop(user_names, pid_names, pid_server, name_room)
    end
  end
end
