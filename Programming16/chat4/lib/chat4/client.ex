defmodule Chat4.Client do
  def init do
    name = IO.gets("Digite o seu nome: ") |> String.trim()
    pid = :global.whereis_name(Chat4.Master)

    {:ok, pid_print} = Chat4.Client.Printer.start_link(%{name: name, pid_input: self()})

    send(pid, {:register, name, pid_print, self()})
    receive do
      :already_exits ->
        Process.exit(pid_print, :kill)
        init()
      :start ->
        input_loop(name, pid_print)
    end
  end

  def input_loop(name, pid_print) do
    message = IO.gets("> ") |> String.trim()
    pid = :global.whereis_name(Chat4.Master)
    send(pid, {:message_all, message, name, self(), pid_print})

    input_loop(name, pid_print)
  end
end

# {:global, Chat4.Master}
