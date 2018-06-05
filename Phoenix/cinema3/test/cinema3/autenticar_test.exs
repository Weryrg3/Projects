defmodule Cinema3.AutenticarTest do
  use Cinema3.ConnCase

  alias Cinema3.Router

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end
end
