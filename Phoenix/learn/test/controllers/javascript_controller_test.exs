defmodule Learn.JavaScriptControllerTest do
  use Learn.ConnCase

  describe "Paginas de GET simples" do
    test "GET /javascript", %{conn: conn} do
      conn = get(conn, "/javascript")
      assert html_response(conn, 200) =~ "JavaScript"
    end
  end
end
