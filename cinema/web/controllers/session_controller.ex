defmodule Cinema.SessionController do
  use Cinema.Web, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => user, "senha" => senha}}) do
    case Cinema.Auth.login_por_username(conn, user, senha, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Bem vindo de volta!")
        |> redirect(to: page_path(conn, :index))

      {:error, :unauthorized, conn} ->
        conn
        |> put_flash(:error, "Inválido username/senha")
        |> render("new.html")

      {:error, :not_found, conn} ->
        conn
        |> put_flash(:error, "Usuário não encontrado!!")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Cinema.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
