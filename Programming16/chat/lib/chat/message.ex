defmodule Chat.Message do
  def recebe_mensagens() do
    receive do
      {:msg, user, msg, who} ->
        IO.puts("[#{user}, #{who}]: #{msg} ")

      {:new_user, name_user, online_peoples} ->
        IO.puts("#{name_user} entrou na sala")
        IO.puts("#{online_peoples} pessoas online")
        IO.inspect("recebe mensagens #{inspect self()}")
        send(self(), {:test1, "Test1"})

      {:not_found, user} ->
        IO.puts("Usúario #{user} não foi encontrado")

      {:exit, user, people} ->
        IO.puts("#{user} saiu da sala.")
        IO.puts("#{people} pessoas online")

      {:new_server, name_server} ->
        
    end

    recebe_mensagens()
  end

  def enviar_mensagens(server, pid, three) do
    msg = String.trim(IO.gets("Enviar mensagem: "))

    if String.contains?(msg, " @") do
      msg_c = String.split(msg, "@") |> List.to_tuple()
      # require IEx; IEx.pry
      case elem(msg_c, 1) do
        "todos" ->
          send(server, {:msg_server, elem(msg_c, 0), "todos", pid})
          # enviar_mensagens(server, pid)

        user ->
          send(server, {:msg_server, elem(msg_c, 0), user, pid})
          # enviar_mensagens(server, pid)
      end
    else
      who? = String.trim(IO.gets("Para quem? "))
      send(server, {:msg_server, msg, who?, pid})
      # enviar_mensagens(server, pid)
    end
    enviar_mensagens(server, pid, three)
  end
end
