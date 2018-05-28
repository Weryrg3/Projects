defmodule Cinema3.PageControllerTest do
  use Cinema3.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  describe "testando links que estão na page" do
    test "link para página inicial de usuário sem autentificação", %{conn: conn} do
      conn = get(conn, "/usuario/")
      assert html_response(conn, 302)
    end

    test "link para criar nova conta de usuário", %{conn: conn} do
      conn = get(conn, "/usuario/new")
      assert html_response(conn, 200) =~ "Criar uma nova conta"
    end
  end
end
