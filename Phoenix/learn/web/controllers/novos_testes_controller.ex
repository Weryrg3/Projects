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

  # novos_testes_path PUT /novostestes/:id :update
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

  def file_read do
    "#{File.cwd!()}/lib/learn/pos.txt"
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn str ->
      String.split(str, "=") |> List.to_tuple()
    end)
    |> Map.new()
  end

  def file_write(map) do
    str =
      Map.to_list(map)
      |> Enum.map(fn {pos, cor} -> "#{pos}=#{cor}" end)
      |> Enum.join("\n")

    File.write!("#{File.cwd!()}/lib/learn/pos.txt", str)
  end

  defp pos("random") do
    file = file_read()

    Map.merge(file, file, fn m, p1, _ ->
      if m == "cor" do
        p1
      else
        Enum.random(["primary", "danger", "success", "info", "warning"])
      end
    end)
  end

  defp pos(cor) do
    file = file_read()

    Map.merge(file, file, fn m, p1, _ ->
      if m == "cor" do
        p1
      else
        cor
      end
    end)
  end

  def delete_keys_map(map) do
    keys =
      Enum.map(map, fn {pos, cor} ->
        if cor != "default" or pos == "cor", do: pos
      end)

    map = Map.drop(map, keys)
    {length(Map.to_list(map)), map}
  end

  def buttons2(conn, %{"automatico" => "automatico"}) do
    {tamanho, map} = delete_keys_map(file_read())
    cor = file_read()["cor"]

    if tamanho > 0 do
      {pos, _cor} = Enum.random(map)
      buttons2(conn, %{pos => cor})
    else
      render(conn, "buttons2.html", buttons: file_read())
    end
  end

  def buttons2(conn, %{"clear" => "clear"}) do
    pos = pos("default")
    file_write(pos)

    render(conn, "buttons2.html", buttons: pos)
  end

  def buttons2(conn, %{"all" => "all"}) do
    pos = pos(file_read()["cor"])
    file_write(pos)

    render(conn, "buttons2.html", buttons: pos)
  end

  def buttons2(conn, params) do
    file = file_read()
    cor_automatica = Enum.random(["primary", "danger", "success", "info", "warning"])

    map =
      Map.merge(file, params, fn m, p1, p2 ->
        case p1 do
          "default" ->
            if p2 == "random" do
              cor_automatica
            else
              p2
            end

          _ ->
            cond do
              m == "cor" and p1 == "random" ->
                "primary"

              m == "cor" and p1 != "random" ->
                p2

              true ->
                "default"
            end
        end
      end)

    new_map =
      if conn.params == %{"automatico" => "automatico"} do
        Map.update!(map, "cor", fn _ -> cor_automatica end)
      end

    file_write(new_map || map)

    render(conn, "buttons2.html", buttons: map)
  end
end

# novos_testes_path PATCH /novostestes/:id :update
