defmodule Cinema.UserController do
  use Cinema.Web, :controller
  alias Cinema.User
  alias Cinema.DB

  plug(:autenticar when action in [:index])

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
      case DB.insert_in_db(user_params) do
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

  defp autenticar(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Você precisa estar logado para acessar essa página")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
