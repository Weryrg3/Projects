defmodule Chat3.Room do
  def new_room do
    IO.gets("Digite o nome da sala: ")
    |> String.trim()
    |> String.to_atom()
  end
end
