defmodule Chat do
  alias Chat.{Room, Client, Controler}
  def iniciar do
    room = iniciar_chat("Digite o nome da nova sala: ")
    user = iniciar_chat("Digite o nome de usuário: ")

    pid_room = Room.iniciar_room(room)
    Client.iniciar_client(user, pid_room)
  end

  defp iniciar_chat(arg) do
    new_chat = String.trim(IO.gets(arg))
    y_n = IO.gets("[#{new_chat}] O nome está correto? ") |> String.trim() |> String.upcase()
    answer = ".SIM.S.Y.YES.."
    if String.contains?(answer, "." <> y_n <> ".") do
      new_chat
    else
      iniciar_chat(arg)
    end
  end
end

# bug, quando usúario que iniciou o server sai
# implementar desentralizar o servidor, quando usuário principal sair, troca para proximo na lista.
