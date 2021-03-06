defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def delete(conn, _) do
    conn
    |> Rumbl.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Rumbl.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Bem vindo de volta!")
        |> redirect(to: page_path(conn, :index))

      {:error, :unauthorized, conn} ->
        conn
        |> put_flash(:error, "Combinação inválida username/password")
        |> render("new.html")

      {:error, :not_found, conn} ->
        conn
        |> put_flash(:error, "Usuário não encontrado!!!")
        |> render("new.html")
    end
  end
end
