defmodule Chat.Message do
  def enviar_mensagens(server, pid) do
    msg = String.trim(IO.gets("Enviar mensagem: "))
    who? = String.trim(IO.gets("Para quem? "))
    send(server, {:msg_server, msg, who?, pid})
    enviar_mensagens(server, pid)
  end

  def recebe_mensagens() do
    receive do
      {:msg, user, msg, who} ->
        IO.puts("[#{user}, #{who}]: #{msg} ")

      {:new_user, user, people} ->
        IO.puts("#{user} entrou na sala")
        IO.puts("#{people} pessoas online")

      {:not_found, user} ->
        IO.puts("Usúario #{user} não foi encontrado")

      {:exit, user, people} ->
        IO.puts("#{user} saiu da sala.")
        IO.puts("#{people} pessoas online")
    end
    recebe_mensagens
  end
end
