defmodule Learn.CalculadoraController do
  use Learn.Web, :controller

  # calculadora_path GET /calculadora/:op :index
  def index(conn, %{"op" => op}) do
    render(conn, "index.html", operation: op)
  end
end

