defmodule Learn.RelacionamentosController do
  use Learn.Web, :controller
  alias Learn.Relacionamentos

  # relacionamentos_path GET /relacionamentos :index
  def index(conn, _) do
    relacionamentos = Repo.all(Relacionamentos)
    render(conn, "index.html", relacionamentos: relacionamentos)
  end

  # relacionamentos_path GET /relacionamentos/new :new
  def new(conn, params) do
    changeset =
      params
      |> build_assoc(:relacionamentos)
      |> Relacionamentos.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  # relacionamentos_path POST /relacionamentos :create
  def create(conn, %{"relacionamentos" => changeset}) do
    changeset = Relacionamentos.changeset(%Relacionamentos{}, changeset)
    # sem segurança
    case Repo.insert(changeset) do
      {:ok, _relacionamento} ->
        conn
        |> put_flash(:info, "O relacionamento foi criado com sucesso!!")
        |> redirect(to: novos_testes_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # relacionamentos_path GET /relacionamentos/:id/edit :edit
  def edit(conn, %{"id" => id}) do
    relacionamento = Repo.get!(Relacionamentos, id)
    changeset = Relacionamentos.changeset(relacionamento)
    render(conn, "edit.html", relacionamento: relacionamento, changeset: changeset)
  end

  # relacionamentos_path PUT /relacionamentos/:id :update
  def update(conn, %{"id" => id, "relacionamentos" => params}) do
    relacionamento = Repo.get!(Relacionamentos, id)
    changeset = Relacionamentos.changeset(relacionamento, params)

    if changeset.changes == %{} do
      conn
      |> put_flash(:error, "Sem alterações!!")
      |> render("edit.html", relacionamento: relacionamento, changeset: changeset)
    end

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Relacionamento alterado com sucesso!")
        |> redirect(to: novos_testes_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", relacionamento: relacionamento, changeset: changeset)
    end
  end

  # relacionamentos_path DELETE /relacionamentos/:id :delete
  def delete(conn, %{"id" => id}) do
    relacionamento = Repo.get!(Relacionamentos, id)
    Repo.delete!(relacionamento)

    conn
    |> put_flash(:info, "Relacionamento excluid com sucesso!")
    |> redirect(to: novos_testes_path(conn, :index))
  end
end

# relacionamentos_path GET /relacionamentos/:id :show
# relacionamentos_path PATCH /relacionamentos/:id :update
