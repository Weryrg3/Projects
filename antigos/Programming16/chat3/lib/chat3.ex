defmodule Chat3 do

  def iniciar do
    room = {:global, Chat3.Room.new_room()}

    {:ok, pid_manager} = Chat3.Manager.start_link("manager")

    GenServer.start_link(Chat3.Server, pid_manager, name: room)

    new_user(Chat3.Client.new_client(), room)
    IO.inspect(show(room))
    room
  end

  def show(room) do
    GenServer.call(room, :show)
  end

  defp new_user({user_name, pid_name}, room) do
    GenServer.cast(room, {:new, user_name, pid_name})
  end
end
