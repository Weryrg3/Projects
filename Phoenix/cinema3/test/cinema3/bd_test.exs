defmodule Cinema3.BDTest do
  use Cinema3.ModelCase
  alias Cinema3.BD

  @params %{
    "username" => "We1",
    "nome" => "Wesley",
    "cpf" => "12345678945",
    "rg" => "1234789",
    "telefone" => "45698745",
    "endereco" => "rua das avenidas"
  }

  describe "Usuarios" do
    test "Testando ao inserir usuário null" do
      assert {:error, _} = BD.inserir_usuario(%{})
    end

    test "testando ao inserir com valores válidos" do
      assert {:ok, _} = BD.inserir_usuario(@params)
    end
  end
end
