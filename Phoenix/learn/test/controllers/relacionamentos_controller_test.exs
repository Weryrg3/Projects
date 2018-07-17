defmodule Learn.RelacionamentosControllerTest do
  use Learn.ConnCase

  alias Learn.Relacionamentos

  describe "Páginas de GET simples" do
    test "get /relacionamentos index", %{conn: conn} do
      insert_relacionamentos(%{nome: "Test rel"})
      conn = get(conn, "/relacionamentos")
      assert html_response(conn, 200) =~ "Test rel"
    end

    test "GET /relacionamentos/id show", %{conn: conn} do
      %{id: id_rel} = insert_relacionamentos(%{nome: "Test show"})
      conn = get(conn, "/relacionamentos/#{id_rel}", %{"id" => id_rel})
      assert has_in_bd?(Relacionamentos)
      assert html_response(conn, 200) =~ "Nome_button: Test show"
    end

    test "GET /relacionamentos/main_buttons3 ", %{conn: conn} do
      %{id: id_testes} = insert_novos_testes(%{texto: "Main buttons3"})
      changeset = relacionamento(%{nome: "Teste Main buttons3"})

      conn =
        post(conn, "/relacionamentos", %{"relacionamentos" => changeset, "id_user" => id_testes})

      conn = get(conn, "/relacionamentos/main_buttons3", %{"id_novos_testes" => id_testes})
      assert html_response(conn, 200) =~ "Teste Main buttons3"
    end

    test "GET /relacionamentos/buttons3", %{conn: conn} do
      conn = get(conn, "/relacionamentos/buttons3")
      assert html_response(conn, 200)
    end
  end

  describe "Testes CRUD" do
    test "get /relacionamentos/new", %{conn: conn} do
      %{id: id} = insert_novos_testes(%{texto: "Teste novo rel"})
      conn = get(conn, "/relacionamentos/new", %{"id" => id})
      assert html_response(conn, 200) =~ "13x13"
    end

    test "POST /relacionamentos criar", %{conn: conn} do
      texto = "Teste novo rel2"
      %{id: id_testes} = insert_novos_testes(%{texto: texto})
      changeset = relacionamento(%{nome: "Teste create"})

      conn =
        post(conn, "/relacionamentos", %{"relacionamentos" => changeset, "id_user" => id_testes})

      assert rel = get_bd_by(Relacionamentos, nome: "Teste create")
      assert preload_in_bd(rel, :novos_testes).novos_testes.texto == texto
      assert html_response(conn, 302)
    end

    test "POST /relacionamentos create sem params", %{conn: conn} do
      %{id: id} = insert_novos_testes(%{texto: "Teste novo rel3"})
      message = "Algo deu errado! Verifique os erros e tente novamente!!"
      conn = post(conn, "/relacionamentos", %{"relacionamentos" => %{}, "id_user" => id})
      assert html_response(conn, 200) =~ message
    end

    test "GET /relacionamentos/:id/edit edita", %{conn: conn} do
      %{id: id} = insert_relacionamentos(%{name: "Teste_edit"})
      conn = get(conn, "/relacionamentos/#{id}/edit")
      assert html_response(conn, 200) =~ "Editar relacionamentos"
    end

    test "PUT /relacionamentos/:id update atualiza", %{conn: conn} do
      %{id: id_rel} = insert_relacionamentos(%{nome: "Teste update"})
      params = %{nome: "Teste update 2"}
      conn = put(conn, "/relacionamentos/#{id_rel}", %{"relacionamentos" => params})
      assert get_bd(Relacionamentos, id_rel).nome == "Teste update 2"
      assert html_response(conn, 302)
    end

    test "PUT /relacionamentos/:id update atualiza com params vazio", %{conn: conn} do
      %{id: id_rel} = insert_relacionamentos(%{nome: "Teste update"})
      conn = put(conn, "/relacionamentos/#{id_rel}", %{"id" => id_rel, "relacionamentos" => %{}})
      assert get_bd(Relacionamentos, id_rel).nome == "Teste update"
      assert html_response(conn, 302)
    end

    test "PUT /relacionamentos/:id update atualiza com params inválido", %{conn: conn} do
      %{id: id_rel} = insert_relacionamentos(%{nome: "Teste update"})

      conn =
        put(conn, "/relacionamentos/#{id_rel}", %{"id" => id_rel, "relacionamentos" => %{nome: 1}})

      assert get_bd(Relacionamentos, id_rel).nome == "Teste update"
      assert html_response(conn, 200) =~ "Algo deu errado! Verifique os erros e tente novamente!!"
    end

    test "DELETE /relacionamentos/:id deleta um objeto", %{conn: conn} do
      %{id: id_rel} = insert_relacionamentos(%{nome: "Teste update"})
      conn = delete(conn, "/relacionamentos/#{id_rel}", %{"id" => id_rel})
      refute get_bd(Relacionamentos, id_rel)
      refute has_in_bd?(Relacionamentos)
      assert html_response(conn, 302)
    end

    test "DELETE /relacionamentos/:id deleta todos objetos", %{conn: conn} do
      insert_relacionamentos(%{nome: "Teste update0"})
      insert_relacionamentos(%{nome: "Teste update1"})
      insert_relacionamentos(%{nome: "Teste update2"})
      conn = delete(conn, "/relacionamentos/todos", %{"id" => "todos"})
      refute has_in_bd?(Relacionamentos)
      assert html_response(conn, 302)
    end
  end
end
