defmodule Chat4.Client do
  def init do
    name = IO.gets("Digite o seu nome: ") |> String.trim()
    pid = :global.whereis_name(Chat4.Master)

    {:ok, pid_print} = Chat4.Client.Printer.start_link([])

    send(pid, {:register, name, pid_print, self()})

    receive do
      :already_exits ->
        Process.exit(pid_print, :kill)
        init()

      :start ->
        pid_server = :global.whereis_name(Chat4.Master)
        # Process.monitor(pid_server)
        {:ok, manager} =
          Chat4.Manager.start_link(%{
            client: %{user_name: name, pid_print: pid_print, pid_input: self()},
            server: pid_server
          })

        input_loop(name, pid_print, pid_server, manager)
    end
  end

  def input_loop(name, pid_print, pid_server, manager) do
    receive do
      {:new_server, server} ->
        input_loop(name, pid_print, server, manager)
    after
      0 ->
        send(manager, {:server, pid_server})
        message(name, pid_print, pid_server)
        input_loop(name, pid_print, pid_server, manager)
    end
  end

  defp message(name_sender, pid_print, pid_server) do
    message = IO.gets("> ") |> String.trim()

    if String.contains?(message, " @") do
      [message, name_receive] = String.split(message, " @")
      send(pid_server, {:private, message, name_sender, self(), pid_print, name_receive})
    else
      send(pid_server, {:message_all, message, name_sender, self(), pid_print})
    end
  end
end
