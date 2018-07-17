defmodule Learn.RelacionamentosController do
  use Learn.Web, :controller

  alias Learn.{
    BD,
    NovosTestes,
    Relacionamentos
  }

  # relacionamentos_path GET /relacionamentos :index
  def index(conn, _) do
    relacionamentos = BD.get_all_files(Relacionamentos)
    render(conn, "index.html", relacionamentos: relacionamentos)
  end

  # relacionamentos_path GET /relacionamentos/new :new
  def new(conn, %{"id" => id}) do

    user = BD.get_file_by_id(NovosTestes, id)

    changeset =
      user
      |> build_assoc(:relacionamentos)
      |> Relacionamentos.changeset()

    render(conn, "new.html", changeset: changeset, id_user: id)
  end

  # relacionamentos_path POST /relacionamentos :create
  def create(conn, %{"id_user" => id, "relacionamentos" => changeset}) do
    # changeset = Relacionamentos.changeset(%Relacionamentos{}, changeset)
    changeset =
      NovosTestes
      |> BD.get_file_by_id(id)
      |> build_assoc(:relacionamentos)
      |> Relacionamentos.changeset(changeset)

    case BD.insert_data(changeset) do
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
    relacionamento = BD.get_file_by_id(Relacionamentos, id)
    changeset = Relacionamentos.changeset(relacionamento)
    render(conn, "edit.html", relacionamento: relacionamento, changeset: changeset)
  end

  # relacionamentos_path PUT /relacionamentos/:id :update
  def update(conn, %{"id" => id, "relacionamentos" => params}) do
    relacionamento = BD.get_file_by_id(Relacionamentos, id)
    changeset = Relacionamentos.changeset(relacionamento, params)

    if changeset.changes == %{} do
      conn
      # |> put_flash(:error, "Sem alterações!!")
      |> render("edit.html", relacionamento: relacionamento, changeset: changeset)
    end

    case BD.update_file(changeset) do
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
    if id == "todos" do
      BD.delete_all(Relacionamentos)
    else
      relacionamento = BD.get_file_by_id(Relacionamentos, id)
      BD.delete_file(relacionamento)
    end

    conn
    |> put_flash(:info, "Relacionamento excluído com sucesso!")
    |> redirect(to: relacionamentos_path(conn, :index))
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

  # relacionamentos_path GET /relacionamentos/:id :show
  def show(conn, %{"id" => id}) do
    rel = BD.get_file_by_id(Relacionamentos, id)
    render(conn, "show.html", rel: rel)
  end

  # relacionamentos_path GET /relacionamentos/main_buttons3 :main_buttons3
  def main_buttons3(conn, %{"id_novos_testes" => id}) do
    user = BD.get_file_by_id(NovosTestes, id)
    rel = BD.preload(user, :relacionamentos)
    render(conn, "main_buttons3.html", rel: rel.relacionamentos)
  end

  # relacionamentos_path GET /relacionamentos/buttons3 :buttons3
  def buttons3(conn, _) do
    render(conn, "buttons3.html")
  end
end
