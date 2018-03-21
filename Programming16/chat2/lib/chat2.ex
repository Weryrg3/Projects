defmodule Chat2 do
  alias Chat2.{Managenment, Client}
  def init_new_server() do
    new_client = IO.gets("Type a name of the user: ") |> String.trim()
    # new_room = IO.gets("Type a name of the room: ") |> String.trim()
    manager = spawn(Managenment, :manager, [])
    Client.new_client(new_client, manager)
    :new_server
  end
end
