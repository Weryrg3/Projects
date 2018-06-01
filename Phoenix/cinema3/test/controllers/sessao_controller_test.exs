defmodule Cinema3.SessaoControllerTest do
  use Cinema3.ConnCase

  setup %{conn: conn} = config do
    if username = config[:login_como] do
      usuario = inserir_usuario(%{username: username})
      conn = assign(build_conn(), :usuario_atual, usuario)
      {:ok, conn: conn, usuario: usuario}
    else
      :ok
    end
  end
  test "testando Get/sessoes/new", %{conn: conn} do
    conn = get(conn, "/sessao/new")
    assert html_response(conn, 200)
  end

  @tag login_como: "Teste1"
  test "testando GET/sessoes/ com usuário existente", %{conn: conn, usuario: usuario} do
    conn = post(conn, sessao_path(conn, :create), %{"sessao" => %{"username" => usuario.username, "senha" => usuario.senha}})
    conn = get(conn, "/usuario/")
    assert html_response(conn, 200)
  end

  # test "testando GET/usuarios/ com valores inválidos", %{conn: conn} do
  #   conn = post(conn, usuario_path(conn, :create), usuario: %{})
  #   conn = get(conn, "/usuario/")
  #   assert html_response(conn, 302)
  # end
end
