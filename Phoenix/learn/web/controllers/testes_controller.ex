defmodule Learn.TestesController do
  use Learn.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def teste1(conn, _params) do
    render(conn, "teste1.html")
  end

  def teste2(conn, _params) do
    render(conn, "teste2.html")
  end

  def teste_css(conn, _params) do
    render(conn, "teste_css.html")
  end

  def create(conn, %{"testes" => %{"name" => name}}) do
    conn
    |> put_flash(:info, "Bem vindo #{name}!!")
    |> redirect(to: calculadora_path(conn, :index, name))
  end
end
