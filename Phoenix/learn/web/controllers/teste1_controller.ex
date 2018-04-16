defmodule Learn.Teste1Controller do
  use Learn.Web, :controller

  def show(conn, _params) do
    render conn, "teste1.html"
  end
end
