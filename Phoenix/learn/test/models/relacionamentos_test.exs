defmodule Learn.RelacionamentosTest do
  use Learn.ModelCase

  alias Learn.Relacionamentos

  @params_valido %{campo: "teste model 1", nome: "teste 1"}
  @params_invalido %{campo: 1}

  describe "testes válidos" do
    test "teste com params válidos" do
      changeset =
        Relacionamentos.changeset(
          %Relacionamentos{},
          @params_valido
        )

      assert %{campo: _, nome: _} = changeset.changes
      assert [] = changeset.errors
      assert changeset.valid?
    end
  end

  describe "testes inválidos" do
    test "teste com param campo inválido" do
      changeset =
        Relacionamentos.changeset(
          %Relacionamentos{},
          @params_invalido
        )

      errors = changeset.errors
      assert %{} = changeset.changes
      assert [nome: _, campo: _] = errors
      assert String.contains?(inspect(errors), ["is invalid", "can't be blank"])
      refute changeset.valid?
    end

    test "teste com param vazio" do
      changeset =
        Relacionamentos.changeset(
          %Relacionamentos{},
          %{}
        )

      errors = changeset.errors
      assert %{} = changeset.changes
      assert [campo: _, nome: _] = errors
      assert String.contains?(inspect(errors), ["required", "can't be blank"])
      refute changeset.valid?
    end
  end
end
