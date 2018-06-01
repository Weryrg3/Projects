defmodule Cinema3.FilmeControllerTest do
  use Cinema3.ConnCase

  @params %{
    "nome" => "testando",
    "ano" => "testando",
    "sinopse" => "testando",
    "elenco" => "testando",
    "formato" => "testando",
    "duracao" => "testando",
    "categoria" => "testando",
    "classificacao" => "testando"
  }

  test "testando GET/filmes/new", %{conn: conn} do
    conn = get(conn, "/filmes/new")
    assert html_response(conn, 200) =~ "Adicionar um novo filme"
  end
end
