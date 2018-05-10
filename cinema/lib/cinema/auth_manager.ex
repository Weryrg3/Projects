defmodule Cinema.AuthManager do
  import Plug.Conn
  import Phoenix.Controller
  alias Cinema.Router.Helpers

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Cinema.User, user_id)
    assign(conn, :current_manager, user)
  end
end
