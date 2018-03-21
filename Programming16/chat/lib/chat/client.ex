defmodule Chat.Client do
  alias Chat.{Server, Message}
  def iniciar_client(user, server) do
    # input
    pid = spawn(Server, :register, [user, server, self()])
    receive do
      :already_exits ->
        IO.puts("Já existe um usuário com esse nome")
      :continue ->
        Message.enviar_mensagens(server, pid, self())
    end
  end
end
