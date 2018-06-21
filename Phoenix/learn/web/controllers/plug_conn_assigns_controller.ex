defmodule Learn.PlugConnAssignsController do
  use Learn.Web, :controller

  # plug_conn_assigns_path GET /plug/:p :index
  def index(conn, params) do
    conn
    |> assign(:teste, %{a1: 1})
    |> configure_session(renew: true)
    |> render("index.html", [param: params, conn2: conn])
  end
end
