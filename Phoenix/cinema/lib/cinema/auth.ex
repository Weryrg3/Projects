defmodule Cinema.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller
  alias Cinema.Router.Helpers

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Cinema.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_por_username(conn, username, senha, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Cinema.User, username: username)

    cond do
      user && checkpw(senha, user.senha_hash) ->
        {:ok, login(conn, user), user.permission}

      user ->
        {:error, :unauthorized, conn}

      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def autenticar_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Você precisa estar logado para acessar essa página")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end

  def autenticar_manager(conn, _opts) do
    if conn.assigns.current_user.permission do
      conn
    else
      conn
      |> put_flash(:error, "Você não tem permissão para isso")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end
