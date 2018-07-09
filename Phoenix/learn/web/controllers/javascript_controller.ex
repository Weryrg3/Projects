defmodule Learn.JavaScriptController do
  use Learn.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
