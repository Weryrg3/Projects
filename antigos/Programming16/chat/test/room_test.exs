defmodule TestRoom do
  alias Chat.Room
  use ExUnit.Case

  test "test de retorno" do
    assert is_pid(Room.iniciar_room("Sala1"))
  end
end
