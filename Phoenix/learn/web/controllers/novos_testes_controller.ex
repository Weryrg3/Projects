defmodule Learn.NovosTestesController do
  use Learn.Web, :controller
  alias Learn.NovosTestes, as: NovosT
  # novos_testes_path GET /novostestes :index
  def index(conn, _) do
    testes = Repo.all(NovosT)
    render(conn, "index.html", testes: testes)
  end

  # novos_testes_path GET /novostestes/new :new
  def new(conn, _) do
    changeset = NovosT.changeset(%NovosT{})
    render(conn, "new.html", changeset: changeset)
  end

  # novos_testes_path POST /novostestes :create
  def create(conn, %{"novos_testes" => changeset}) do
    changeset = NovosT.changeset(%NovosT{}, changeset)
    Repo.insert!(changeset) # sem segurança

    conn
    |> put_flash(:info, "teste feito com sucesso")
    |> redirect(to: novos_testes_path(conn, :index))
  end

  def edit(conn, id) do
    
  end
end

# novos_testes_path GET /novostestes/:id/edit :edit
# novos_testes_path GET /novostestes/:id :show
# novos_testes_path PATCH /novostestes/:id :update
# novos_testes_path PUT /novostestes/:id :update
# novos_testes_path DELETE /novostestes/:id :delete
