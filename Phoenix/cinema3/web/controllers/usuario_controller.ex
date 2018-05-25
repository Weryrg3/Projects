defmodule Cinema3.UsuarioController do
  use Cinema3.Web, :controller
  alias Cinema3.BD

  # usuario_path GET /Usuario :index
  def index(conn, _) do
    render(conn, "index.html")
  end

  # usuario_path GET /Usuario/new :new
  def new(conn, _) do
    changeset = BD.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  # usuario_path POST /Usuario :create
  def create(conn, %{"usuario" => usuario_params}) do
    case BD.inserir_usuario(usuario_params) do
      {:ok, usuario} ->
        conn
        |> put_flash(:info, "A conta #{usuario.nome} foi criada!")
        |> redirect(to: usuario_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  # usuario_path GET /Usuario/:id/edit :edit
  # usuario_path GET /Usuario/:id :show
  # usuario_path PATCH /Usuario/:id :update
  # PUT /Usuario/:id :update
  # usuario_path DELETE /Usuario/:id :delete
end
