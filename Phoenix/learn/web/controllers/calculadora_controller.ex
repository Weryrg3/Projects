defmodule Learn.CalculadoraController do
  use Learn.Web, :controller

  def index(conn, %{"op" => op}) do
    render(conn, "index.html", operation: op)
  end
end
