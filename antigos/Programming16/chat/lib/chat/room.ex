defmodule Chat.Room do
  alias Chat.Server

  def iniciar_room(name_room) do
    name_atom = String.to_atom(name_room)

    case :global.register_name(name_atom, Server.iniciar_server(name_room)) do
      :yes ->
        IO.puts("Criando sala nome: #{name_room}")
        :global.register_name(name_atom, Server.iniciar_server(name_room))
      :no ->
        IO.puts("Entrando na sala #{name_room}")
    end

    :global.whereis_name(name_atom)
    # Client.iniciar_client(user, server_global)
  end
end
