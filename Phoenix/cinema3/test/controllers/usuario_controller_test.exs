defmodule Cinema3.UsuarioControllerTest do
  use Cinema3.ConnCase
  # alias Cinema3.Usuario

  @params %{
    "username" => "We1",
    "nome" => "Wesley",
    "cpf" => "12345678945",
    "rg" => "1234789",
    "telefone" => "45698745",
    "endereco" => "rua das avenidas",
    "senha" => "123456",
    "senha_confirm" => "123456"
  }

  test "testando GET/usuarios/new", %{conn: conn} do
    conn = get(conn, "/usuario/new")
    assert html_response(conn, 200) =~ "Criar uma nova conta"
  end

  test "testando GET/usuarios/ com valores válidos", %{conn: conn} do
    conn = post(conn, usuario_path(conn, :create), usuario: @params)
    conn = get(conn, "/usuario/")
    assert html_response(conn, 200)
  end

  test "testando GET/usuarios/ com valores inválidos", %{conn: conn} do
    conn = post(conn, usuario_path(conn, :create), usuario: %{})
    conn = get(conn, "/usuario/")
    assert html_response(conn, 302)
  end
end
