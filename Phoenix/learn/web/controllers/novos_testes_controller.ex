defmodule Learn.NovosTestesController do
  use Learn.Web, :controller
  alias Learn.NovosTestes, as: NovosT

  # plug :teste1_plug when action in [:index, :new]

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
    # sem segurança
    case Repo.insert(changeset) do
      {:ok, teste} ->
        conn
        |> put_flash(:info, "O #{teste.texto} foi feito com Sucesso!!!")
        |> redirect(to: novos_testes_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # novos_testes_path GET /novostestes/:id/edit :edit
  def edit(conn, %{"id" => id}) do
    teste = Repo.get!(NovosT, id)
    changeset = NovosT.changeset(teste)
    render(conn, "edit.html", teste: teste, changeset: changeset)
  end

  def update(conn, %{"id" => id, "novos_testes" => params}) do
    teste = Repo.get!(NovosT, id)
    changeset = NovosT.changeset(teste, params)

    if changeset.changes == %{} do
      conn
      |> put_flash(:error, "Sem alterações!!")
      |> render("edit.html", teste: teste, changeset: changeset)
    end

    case Repo.update(changeset) do
      {:ok, teste} ->
        conn
        |> put_flash(:info, "Novo teste atualizado com sucesso!!")
        |> redirect(to: novos_testes_path(conn, :show, teste))

      {:error, changeset} ->
        render(conn, "edit.html", teste: teste, changeset: changeset)
    end
  end

  def links(conn, _) do
    render(conn, "links.html")
  end

  # novos_testes_path GET /novostestes/:id :show
  def show(conn, %{"id" => id}) do
    teste = Repo.get!(NovosT, id)
    render(conn, "show.html", teste: teste)
  end

  # novos_testes_path DELETE /novostestes/:id :delete
  def delete(conn, %{"id" => id}) do
    if id == "todos" do
      Repo.delete_all(NovosT)

      conn
      |> put_flash(:info, "testes excluídos com sucesso")
      |> redirect(to: novos_testes_path(conn, :index))
    else
      teste = Repo.get!(NovosT, id)
      Repo.delete!(teste)

      conn
      |> put_flash(:info, "teste excluído com sucesso")
      |> redirect(to: novos_testes_path(conn, :index))
    end
  end

end

# novos_testes_path PATCH /novostestes/:id :update
# novos_testes_path PUT /novostestes/:id :update
