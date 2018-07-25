defmodule Learn.NovosTestesControllerTest do
  use Learn.ConnCase

  alias Learn.NovosTestes

  describe "Páginas de GET simples" do
    test "GET /novostestes", %{conn: conn} do
      insert_novos_testes(%{texto: "teste1"})
      conn = get(conn, "/novostestes")
      assert html_response(conn, 200) =~ "teste1"
    end

    test "GET /novostestes/ show", %{conn: conn} do
      %{id: id} = insert_novos_testes(%{texto: "Teste1"})
      conn = get(conn, "/novostestes/#{id}")
      assert html_response(conn, 200) =~ "Texto: Teste1"
    end

    test "GET /novostestes/testes/links", %{conn: conn} do
      conn = get(conn, "/novostestes/testes/links")
      assert html_response(conn, 200) =~ "Link 4 - delete"
    end
  end

  describe "implementação de buttons get simples" do
    test "GET /novostestes/buttons2 automático ativado", %{conn: conn} do
      params = %{"automatico" => "automatico"}
      conn = get(conn, "/novostestes/buttons2", %{"clear" => "clear"})
      conn = get(conn, "/novostestes/buttons2", params)

      buttons = conn.assigns.buttons
      assert Enum.count(buttons) == 170

      refute inspect(buttons, limit: :infinity) =~ "nil"
      assert html_response(conn, 200) =~ "Random automático ativado"
    end

    test "GET /novostestes/buttons2 automático desativado", %{conn: conn} do
      params = %{"automatico" => "automatico"}
      conn = get(conn, "/novostestes/buttons2", %{"all" => "all"})
      conn = get(conn, "/novostestes/buttons2", params)
      assert Enum.count(conn.assigns.buttons) == 170
      assert html_response(conn, 200) =~ "Random automático desativado"
    end

    test "GET /novostestes/buttons2 clear", %{conn: conn} do
      params = %{"clear" => "clear"}
      conn = get(conn, "/novostestes/buttons2", params)
      assert Enum.count(conn.assigns.buttons) == 170
      assert html_response(conn, 200) =~ "default"
    end

    test "GET /novostestes/buttons2 all", %{conn: conn} do
      params = %{"all" => "all"}
      conn = get(conn, "/novostestes/buttons2", params)
      assert Enum.count(conn.assigns.buttons) == 170
      assert html_response(conn, 200)
    end

    test "GET /novostestes/buttons2 default", %{conn: conn} do
      params = %{"1.01" => "primary"}
      conn = get(conn, "/novostestes/buttons2", params)
      assert Enum.count(conn.assigns.buttons) == 170
      assert html_response(conn, 200)
    end

    test "GET /novostestes/buttons2 random", %{conn: conn} do
      conn = get(conn, "/novostestes/buttons2", %{"cor" => "random"})
      assert Enum.count(conn.assigns.buttons) == 170
      assert html_response(conn, 200)
    end
  end

  describe "Páginas com CRUD" do
    test "GET novostestes/new", %{conn: conn} do
      conn = get(conn, "/novostestes/new")
      assert html_response(conn, 200) =~ "Novo teste"
    end

    test "POST /novostestes create com params", %{conn: conn} do
      novos_testes = novos_testes(%{texto: "teste"})
      conn = post(conn, "/novostestes", %{"novos_testes" => novos_testes})
      assert get_bd_by(NovosTestes, %{texto: "teste"})
      assert html_response(conn, 302)
    end

    test "POST /novostestes create sem params", %{conn: conn} do
      message = "Algo deu errado! Verifique os erros e tente novamente!!"
      conn = post(conn, "/novostestes", %{"novos_testes" => %{}})
      assert html_response(conn, 200) =~ message
    end

    test "GET /novostestes/:id/edit edita", %{conn: conn} do
      %{id: id} = insert_novos_testes(%{texto: "Teste_edit"})
      conn = get(conn, "/novostestes/#{id}/edit")
      assert html_response(conn, 200) =~ "Teste_edit"
    end

    test "PUT /novostestes/:id atualiza com params", %{conn: conn} do
      %{id: id} = insert_novos_testes(%{texto: "Teste"})
      params = %{texto: "Teste update"}
      conn = put(conn, "/novostestes/#{id}", %{"id" => id, "novos_testes" => params})
      assert get_bd(NovosTestes, id).texto == "Teste update"
      assert html_response(conn, 302)
    end

    test "PUT /novostestes/:id atualiza sem params", %{conn: conn} do
      %{id: id} = insert_novos_testes(%{texto: "Teste"})
      conn = put(conn, "/novostestes/#{id}", %{"id" => id, "novos_testes" => %{}})
      assert html_response(conn, 302)
    end

    test "PUT /novostestes/:id atualiza com params inválido", %{conn: conn} do
      %{id: id} = insert_novos_testes(%{texto: "Teste"})
      conn = put(conn, "/novostestes/#{id}", %{"id" => id, "novos_testes" => %{texto: 1}})
      assert html_response(conn, 200) =~ "is invalid"
    end

    test "DELETE /novostestes/:id deleta", %{conn: conn} do
      %{id: id} = insert_novos_testes(%{texto: "Teste"})
      conn = delete(conn, "/novostestes/#{id}", %{"id" => id})
      refute get_bd(NovosTestes, id)
      assert html_response(conn, 302)
    end

    test "DELETE /novostestes/:id deleta todos", %{conn: conn} do
      insert_novos_testes()
      insert_novos_testes(%{texto: "test 1"})
      conn = delete(conn, "/novostestes/#{"todos"}", %{"id" => "todos"})
      assert bd_is_empty?(NovosTestes)
      assert html_response(conn, 302)
    end
  end
end
