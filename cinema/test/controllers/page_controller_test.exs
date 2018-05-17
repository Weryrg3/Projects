defmodule Cinema.PageControllerTest do
  use Cinema.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Bem vindo ao Cine{name}"
  end
end
