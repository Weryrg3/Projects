defmodule Learn.Teste3Controller do
  use Learn.Web, :controller

  def teste3(conn, _params) do
    render conn, "teste3.html", teste3: conn
  end
end

