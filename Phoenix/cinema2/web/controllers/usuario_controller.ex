defmodule Cinema2.UsuarioController do
  use Cinema2.Web, :controller
  alias Cinema2.BD

  def index(conn, _) do
    render(conn, "index.html")
  end

  def new(conn, _) do
    changeset = BD.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"usuario" => usuario_params}) do
    usuario = BD.inserir_usuario(usuario_params)

    conn
    |> put_flash(:info, "#{usuario.nome} criado!")
    |> redirect(to: usuario_path(conn, :index))
  end
end
