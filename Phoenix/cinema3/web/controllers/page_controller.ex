defmodule Cinema3.PageController do
  use Cinema3.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
