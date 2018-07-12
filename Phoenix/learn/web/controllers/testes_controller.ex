defmodule Learn.TestesController do
  use Learn.Web, :controller

  # testes_path GET /testes :index
  def index(conn, %{"t" => t}) do
    render(conn, "index.html", action: t)
  end

  # testes_path GET /testes/teste1 :teste1
  def teste1(conn, _params) do
    render(conn, "teste1.html")
  end

  # testes_path GET /testes/teste2 :teste2
  def teste2(conn, _params) do
    render(conn, "teste2.html")
  end

  # testes_path GET /testes/teste_css :teste_css
  def teste_css(conn, _params) do
    render(conn, "teste_css.html")
  end

  # testes_path POST /testes :create
  def create(conn, %{"testes" => %{"name" => name}}) do
    if String.length(name) >= 3 and
    String.contains?(name, ["+", "-", "*", "/", "x"]) do
      redirect(conn, to: calculadora_path(conn, :index, name))
    else
      conn
      |> put_flash(:error, "Argumento inválido tente novamente!!")
      |> render("teste2.html")
    end
  end

  def buttons(conn, %{"pos" => %{"x" => x, "y" => y}}) do
    x = String.to_integer(x)
    y = String.to_integer(y)
    render(conn, "buttons.html", x: x, y: y)
  end
end
