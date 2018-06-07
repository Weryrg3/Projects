defmodule Learn.NovosTestesController do
  use Learn.Web, :controller
  alias Learn.NovosTestes, as: NovosT
  # novos_testes_path GET /novostestes :index
  def index(conn, _) do
    render(conn, "index.html")
  end

  def new(conn, _) do
    changeset = NovosT.changeset(%NovosT{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, params) do
    conn
    |> put_flash(:info, "#{inspect params}!!")
    |> redirect(to: novos_testes_path(conn, :index))
  end
end

# novos_testes_path GET /novostestes/:id/edit :edit
# novos_testes_path GET /novostestes/new :new
# novos_testes_path GET /novostestes/:id :show
# novos_testes_path POST /novostestes :create
# novos_testes_path PATCH /novostestes/:id :update
# novos_testes_path PUT /novostestes/:id :update
# novos_testes_path DELETE /novostestes/:id :delete
