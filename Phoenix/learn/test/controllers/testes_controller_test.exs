defmodule Learn.TestesControllerTest do
  use Learn.ConnCase

  describe "Testes de GET simples" do
    test "GET /testes index", %{conn: conn} do
      conn = get(conn, "/testes", %{"t" => "cima"})
      assert html_response(conn, 200) =~ "Olhe para cima!"
    end

    test "GET /testes/teste1", %{conn: conn} do
      conn = get(conn, "/testes/teste1")
      assert html_response(conn, 200) =~ "Teste 1 feito"
    end

    test "GET /testes/teste2", %{conn: conn} do
      conn = get(conn, "/testes/teste2")
      assert html_response(conn, 200) =~ "Its Working"
    end

    test "GET /testes/teste_css", %{conn: conn} do
      conn = get(conn, "/testes/teste_css")
      assert html_response(conn, 200) =~ "These paragraphs are styled with CSS."
    end

    test "GET /testes/buttons", %{conn: conn} do
      conn = get(conn, "/testes/buttons", %{"pos" => %{"x" => "1", "y" => "1"}})
      assert html_response(conn, 200)
    end
  end

  describe "Testes de CRUD" do
    test "POST /testes create com sucesso", %{conn: conn} do
      name = "10x10"
      conn = post(conn, "/testes", %{"testes" => %{"name" => name}})
      assert html_response(conn, 302) =~ "/calculadora/10x10"
    end

    test "POST /testes create com falha", %{conn: conn} do
      name = "10"
      conn = post(conn, "/testes", %{"testes" => %{"name" => name}})
      assert html_response(conn, 200) =~ "Argumento inválido tente novamente!!"
    end
  end
end
