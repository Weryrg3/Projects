defmodule Cinema.DB do
  alias Cinema.User
  alias Cinema.Repo

  def insert_in_db(user_params) do
    User.registrar_changeset(%User{}, user_params)
    |> Repo.insert()
  end
end
