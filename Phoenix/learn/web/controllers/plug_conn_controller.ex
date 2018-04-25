defmodule Learn.PlugConnController do
  use Learn.Web, :controller

  def index(conn, params) do
    render(conn, "index.html", [param: params, conn2: conn])
  end
end
