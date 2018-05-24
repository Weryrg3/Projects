defmodule Cinema2.PageController do
  use Cinema2.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
