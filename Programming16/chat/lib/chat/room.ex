defmodule Chat.Room do
  alias Chat.{Server, Client}

  def iniciar_room(name_room, user) do
    name_atom = String.to_atom(name_room)

    case :global.register_name(name_atom, Server.iniciar_server()) do
      :yes ->
        IO.puts("Criando sala nome: #{name_room}")
        :global.register_name(name_atom, Server.iniciar_server())

      :no ->
        IO.puts("Entrando na sala #{name_room}")
    end

    server_global = :global.whereis_name(name_atom)
    Client.iniciar_client(user, server_global)
  end
end
