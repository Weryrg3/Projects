defmodule Cinema3.Autenticar do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller
  alias Cinema3.{Router.Helpers, Usuario}

  @moduledoc """
    Atentificação, autentificação de usuários por meio assigns
  """
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    usuario_id = get_session(conn, :usuario_id)

    cond do
      usuario = conn.assigns[:usuario_atual] ->
        conn

      usuario = usuario_id && repo.get(Usuario, usuario_id) ->
        assign(conn, :usuario_atual, usuario)

      true ->
        assign(conn, :usuario_atual, nil)
    end
  end

  def login(conn, usuario) do
    conn
    |> assign(:usuario_atual, usuario)
    |> put_session(:usuario_id, usuario.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def login_por_nome_e_senha(conn, username, senha, opts) do
    repo = Keyword.fetch!(opts, :repo)
    usuario = repo.get_by(Cinema3.Usuario, username: username)
    cond do
      usuario && checkpw(senha, usuario.senha_hash) ->
        {:ok, login(conn, usuario)}

      usuario ->
        {:error, :unauthorized, conn}

      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def autenticar_usuario(conn, _) do
    if conn.assigns.usuario_atual do
      conn
    else
      conn
      |> put_flash(:error, "Você precisa estar logado para acessar essa página")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end
