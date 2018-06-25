defmodule Learn.RelacionamentosController do
  use Learn.Web, :controller
  alias Learn.{Relacionamentos, NovosTestes}

  # relacionamentos_path GET /relacionamentos :index
  def index(conn, _) do
    relacionamentos = Repo.all(Relacionamentos)
    render(conn, "index.html", relacionamentos: relacionamentos)
  end

  # relacionamentos_path GET /relacionamentos/new :new
  def new(conn, %{"id" => id}) do
    user = Repo.get(NovosTestes, id)

    changeset =
      user
      |> build_assoc(:relacionamentos)
      |> Relacionamentos.changeset()

    render(conn, "new.html", changeset: changeset, id_user: id)
  end

  # relacionamentos_path POST /relacionamentos :create
  def create(conn, %{"relacionamentos" => changeset, "id_user" => id}) do
    # changeset = Relacionamentos.changeset(%Relacionamentos{}, changeset)
    changeset =
      Repo.get(NovosTestes, id)
      |> build_assoc(:relacionamentos)
      |> Relacionamentos.changeset(changeset)

    # sem segurança
    case Repo.insert(changeset) do
      {:ok, relacionamento} ->
        button(relacionamento.campo)
        conn
        |> put_flash(:info, "O relacionamento foi criado com sucesso!!")
        |> redirect(to: novos_testes_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, id_user: id)
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

  defp button(string) do
    str =
      string
      |> String.split(["x", "X", "*"])
      |> (fn [n1, n2] ->
            String.to_integer(n1) * String.to_integer(n2)
          end).()
      |> (fn n ->
            Enum.map(1..n, fn n -> "#{n}=default" end)
          end).()
      |> (fn string ->
            string ++ ["cor=default"]
          end).()
      |> Enum.join("\n")

    File.write!("#{File.cwd!()}/lib/learn/user.txt", str)
  end

  def show(conn, %{"id" => id}) do
    rel = Repo.get!(Relacionamentos, id)
    render(conn, "show.html", rel: rel)
  end


  # %{"id" => id}
  def buttons3(conn, _params) do
    user = Repo.get!(NovosTestes, 1)
    rel = Repo.preload(user, :relacionamentos)
    render(conn, "buttons3.html", rel: rel.relacionamentos)
  end
end

# relacionamentos_path GET /relacionamentos/:id :show
# relacionamentos_path PATCH /relacionamentos/:id :update
