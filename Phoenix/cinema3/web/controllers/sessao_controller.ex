defmodule Cinema3.SessaoController do
  use Cinema3.Web, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"sessao" => %{"username" => usuario, "senha" => senha}}) do
    case Cinema3.Autenticar.login_por_nome_e_senha(conn, usuario, senha, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Bem vindo de volta")
        |> redirect(to: page_path(conn, :index))

      {:error, :unauthorized, conn} ->
        conn
        |> put_flash(:error, "Combinação username/senha inválida!!")
        |> render("new.html")

      {:error, :not_found, conn} ->
        conn
        |> put_flash(:error, "Usuário não encontrado")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Cinema3.Autenticar.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
