defmodule Learn.PageControllerTest do
  use Learn.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Esse WebSite é apenas para testes e aprendizado!!!"
  end
end
