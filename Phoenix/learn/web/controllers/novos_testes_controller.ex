defmodule Learn.NovosTestesController do
  use Learn.Web, :controller

  alias Learn.{
    BD,
    Buttons
  }
  alias Learn.NovosTestes, as: NovosT

  # @random ["primary", "danger", "success", "info", "warning"]
  # plug :teste1_plug when action in [:index, :new]
  
  # novos_testes_path GET /novostestes :index
  def index(conn, _) do
    testes = BD.get_all_files(NovosT)
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

    case BD.insert_data(changeset) do
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
    teste = BD.get_file_by_id(NovosT, id)
    changeset = NovosT.changeset(teste)
    render(conn, "edit.html", teste: teste, changeset: changeset)
  end

  # novos_testes_path PUT /novostestes/:id :update
  def update(conn, %{"id" => id, "novos_testes" => params}) do
    teste = BD.get_file_by_id(NovosT, id)
    changeset = NovosT.changeset(teste, params)

    if changeset.changes == %{} do
      conn
      |> put_flash(:error, "Sem alterações!!")
      |> render("edit.html", teste: teste, changeset: changeset)
    end

    case BD.update_file(changeset) do
      {:ok, teste} ->
        conn
        |> put_flash(:info, "Novo teste atualizado com sucesso!!")
        |> redirect(to: novos_testes_path(conn, :show, teste))

      {:error, changeset} ->
        render(conn, "edit.html", teste: teste, changeset: changeset)
    end
  end

  # novos_testes_path GET /novostestes/testes/links :links
  def links(conn, _) do
    render(conn, "links.html")
  end

  # novos_testes_path GET /novostestes/:id :show
  def show(conn, %{"id" => id}) do
    teste = BD.get_file_by_id(NovosT, id)
    render(conn, "show.html", teste: teste)
  end

  # novos_testes_path DELETE /novostestes/:id :delete
  def delete(conn, %{"id" => id}) do
    if id == "todos" do
      BD.delete_all(NovosT)

      conn
      |> put_flash(:info, "testes excluídos com sucesso")
      |> redirect(to: novos_testes_path(conn, :index))
    else
      teste = BD.get_file_by_id(NovosT, id)
      BD.delete_file(teste)

      conn
      |> put_flash(:info, "teste excluído com sucesso")
      |> redirect(to: novos_testes_path(conn, :index))
    end
  end

  ################################
  # Implementação de buttons     #
  ################################

  # novos_testes_path GET /novostestes/buttons2 :buttons2
  def buttons2(conn, %{"automatico" => "automatico"}) do
    {nome_button, tamanho, button_map, cor} =
      Buttons.main_button(
        "automatico",
        "Button_Default"
      )

    if tamanho > 0 do
      {pos, _cor} = Enum.random(button_map)
      buttons2(conn, %{pos => cor})
    else
      button_map = Buttons.get_button(nome_button)
      render(conn, "buttons2.html", buttons: button_map)
    end
  end

  # novos_testes_path GET /novostestes/buttons2 :buttons2
  def buttons2(conn, %{"clear" => "clear"}) do
    map = Buttons.main_button("clear", "Button_Default")
    render(conn, "buttons2.html", buttons: map)
  end

  # novos_testes_path GET /novostestes/buttons2 :buttons2
  def buttons2(conn, %{"all" => "all"}) do
    map = Buttons.main_button("all", "Button_Default")
    render(conn, "buttons2.html", buttons: map)
  end

  # novos_testes_path GET /novostestes/buttons2 :buttons2
  def buttons2(conn, params) do
    map =
      Buttons.main_button(
        "main_button_default",
        params,
        conn.params
      )
    render(conn, "buttons2.html", buttons: map)
  end
end

# novos_testes_path PATCH /novostestes/:id :update
