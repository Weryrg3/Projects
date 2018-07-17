defmodule Learn.PlugConnAssignsControllerTest do
  use Learn.ConnCase

  describe "Get" do
    test "Get /plug/:p index", %{conn: conn} do
      conn = get(conn, "/plug/conn")
      assert html_response(conn, 200) =~ "Conn"
    end
  end
end
