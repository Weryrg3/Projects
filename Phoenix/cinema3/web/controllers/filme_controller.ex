defmodule Cinema3.FilmeController do
  use Cinema3.Web, :controller
  alias Cinema3.BD

  # filme_path GET /filmes :index
  def index(conn, _) do
    filmes = BD.todo(Cinema3.Filme)
    render(conn, "index.html", filmes: filmes)
  end

  def new(conn, _) do
    changeset = BD.changeset_filme()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"filme" => filme_params}) do
    IO.inspect(filme_params)
    case BD.inserir_filme(filme_params) do
      {:ok, filme} ->
        conn
        |> put_flash(:info, "Filme #{filme.nome} adicionado com sucesso!")
        |> redirect(to: filme_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

# filme_path GET /filmes/:id/edit :edit
# filme_path GET /filmes/new :new
# filme_path GET /filmes/:id :show
# filme_path POST /filmes :create
# filme_path PATCH /filmes/:id :update
# filme_path PUT /filmes/:id :update
# filme_path DELETE /filmes/:id :delete
