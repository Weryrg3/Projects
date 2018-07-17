defmodule Learn.CalculadoraControllerTest do
  use Learn.ConnCase

  test "GET /calculadora/1+2", %{conn: conn} do
    conn = get(conn, "/calculadora/1+2")
    assert html_response(conn, 200) =~ "Operação: 1.0 + 2.0 = 3.0"
  end

  test "GET /calculadora/1-2", %{conn: conn} do
    conn = get(conn, "/calculadora/1-2")
    assert html_response(conn, 200) =~ "Operação: 1.0 - 2.0 = -1.0"
  end

  test "GET /calculadora/1*2", %{conn: conn} do
    conn = get(conn, "/calculadora/1*2")
    assert html_response(conn, 200) =~ "Operação: 1.0 * 2.0 = 2.0"
  end

  test "GET /calculadora/1x2", %{conn: conn} do
    conn = get(conn, "/calculadora/1x2")
    assert html_response(conn, 200) =~ "Operação: 1.0 x 2.0 = 2.0"
  end

  test "GET /calculadora/1/2", %{conn: conn} do
    conn = get(conn, "/calculadora/1%2F2")
    assert html_response(conn, 200) =~ "Operação: 1.0 / 2.0 = 0.5"
  end

  test "GET /calculadora/1+2 erro", %{conn: conn} do
    conn = get(conn, "/calculadora/10")
    assert html_response(conn, 200) =~ "Operação: 10"
  end
end
