defmodule Cinema.UserController do
  use Cinema.Web, :controller
  alias Cinema.{User, DB}

  plug(:autenticar_user when action in [:index])

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    if user_params["senha"] != user_params["senha_confirm"] do
      conn
      |> put_flash(:error, "As senhas inseridas não são iguais.")
      |> redirect(to: user_path(conn, :new))
    else
      case DB.insert_in_db_user(user_params) do
        {:ok, user} ->
          conn
          |> Cinema.Auth.login(user)
          |> put_flash(:info, "#{user.nome} criado com sucesso!!")
          |> redirect(to: user_path(conn, :index))

        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Conta alterada com sucesso.")
        |> redirect(to: user_path(conn, :show, user))

      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(_conn, params) do
    IO.inspect(params)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", changeset: changeset, user: user)
  end
end
