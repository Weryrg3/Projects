defmodule Learn.FormControllerTest do
  use Learn.ConnCase

  alias Learn.Thing

  describe "Páginas de GET simples" do
    test "GET /form", %{conn: conn} do
      conn = get(conn, "/form")
      assert html_response(conn, 200) =~ "Qtd: 0"
    end

    test "GET /form com 2 objetos no banco", %{conn: conn} do
      insert_thing()
      insert_thing()
      conn = get(conn, "/form")
      assert html_response(conn, 200) =~ "Qtd: 2"
    end

    test "GET /form/testes", %{conn: conn} do
      conn = get(conn, "/form/testes")
      assert html_response(conn, 200) =~ "Testes"
    end

    test "GET /form/ show", %{conn: conn} do
      %{id: id} = insert_thing(%{name: "Teste1"})
      conn = get(conn, "/form/#{id}")
      assert get_bd(Thing, id).name == "Teste1"
      assert html_response(conn, 200) =~ "Name: Teste1"
    end

    test "GET /form/submit submit com banco vazio", %{conn: conn} do
      conn = get(conn, "/form/submit")
      assert html_response(conn, 302)
    end

    test "GET /form/submit submit com banco com algum objeto", %{conn: conn} do
      insert_thing(%{name: "Teste Submit"})
      conn = get(conn, "/form/submit")
      assert html_response(conn, 200) =~ "Editar"
    end
  end

  describe "Paginas com CRUD" do
    test "GET /form/new", %{conn: conn} do
      conn = get(conn, "/form/new")
      assert html_response(conn, 200) =~ "New Thing"
    end

    test "POST /form create com params", %{conn: conn} do
      thing = thing(%{name: "Teste create"})
      conn = post(conn, "/form", %{"thing" => thing})
      assert get_bd_by(Thing, name: "Teste create")
      assert html_response(conn, 302)
    end

    test "POST /form create sem params", %{conn: conn} do
      message = "Algo deu errado! Verifique os erros e tente novamente!!"
      conn = post(conn, "/form", %{"thing" => %{}})
      assert html_response(conn, 200) =~ message
    end

    test "GET /form/:id/edit edita", %{conn: conn} do
      %{id: id} = insert_thing(%{name: "Teste_edit"})
      conn = get(conn, "/form/#{id}/edit")
      assert get_bd(Thing, id).name == "Teste_edit"
      assert html_response(conn, 200) =~ "Teste_edit"
    end

    test "PUT /form/:id atualiza com params", %{conn: conn} do
      %{id: id} = insert_thing(%{name: "Teste"})
      params = %{name: "Teste update"}
      conn = put(conn, "/form/#{id}", %{"id" => id, "thing" => params})
      assert get_bd(Thing, id).name == "Teste update"
      assert html_response(conn, 302)
    end

    test "PUT /form/:id atualiza sem params", %{conn: conn} do
      %{id: id} = insert_thing(%{name: "Teste"})
      conn = put(conn, "/form/#{id}", %{"id" => id, "thing" => %{}})
      assert html_response(conn, 302)
    end

    test "PUT /form/:id atualiza com params inválido", %{conn: conn} do
      %{id: id} = insert_thing(%{name: "Teste"})
      conn = put(conn, "/form/#{id}", %{"id" => id, "thing" => %{name: 1}})
      assert get_bd(Thing, id).name == "Teste"
      assert html_response(conn, 200) =~ "is invalid"
    end

    test "DELETE /form/:id deleta", %{conn: conn} do
      %{id: id} = insert_thing(%{name: "Teste"})
      conn = delete(conn, "/form/#{id}", %{"id" => id})
      refute get_bd(Thing, id)
      assert html_response(conn, 302)
    end
  end
end
