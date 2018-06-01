defmodule Cinema3.SessaoController do
  use Cinema3.Web, :controller
  alias Cinema3.Autenticar

  # sessao_path GET /sessoes/new :new
  def new(conn, _) do
    render(conn, "new.html")
  end

  # sessao_path POST /sessoes :create
  def create(conn, %{"sessao" => %{"username" => username, "senha" => senha}}) do
    case Autenticar.login_por_nome_e_senha(conn, username, senha, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Bem vindo de volta")
        |> redirect(to: usuario_path(conn, :index))

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
    |> Autenticar.logout()
    |> redirect(to: page_path(conn, :index))
  end
end

# sessao_path GET /sessoes :index
# sessao_path GET /sessoes/:id/edit :edit
# sessao_path GET /sessoes/:id :show
# sessao_path PATCH /sessoes/:id :update
# sessao_path PUT /sessoes/:id :update
# sessao_path DELETE /sessoes/:id :delete
