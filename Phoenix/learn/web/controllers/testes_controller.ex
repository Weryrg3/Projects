defmodule Learn.TestesController do
  use Learn.Web, :controller

  # testes_path GET /testes :index
  def index(conn, _params) do
    render(conn, "index.html")
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
    conn
    |> put_flash(:info, "Bem vindo #{name}!!")
    |> redirect(to: calculadora_path(conn, :index, name))
  end
end
