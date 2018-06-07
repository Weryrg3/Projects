defmodule Rumbl.UserView do
  use Rumbl.Web, :view
  alias Rumbl.User

  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end

  # w123456 Adicionado ↓
  def rende("user.json", %{user: user}) do
    %{id: user.id, username: user.username}
  end
end
