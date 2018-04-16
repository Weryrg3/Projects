defmodule Learn.Teste2Controller do
  use Learn.Web, :controller

  def teste2(conn, _params) do
    render conn, "teste2.html"
  end
end
