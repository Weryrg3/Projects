defmodule Learn.NovosTestesTest do
  use Learn.ModelCase

  alias Learn.NovosTestes

  @params_valido1 %{texto: "teste model 1", num: 1, buttons2: "Texto teste 2"}
  @params_valido2 %{texto: "teste model 2", num: "2", buttons2: "Texto teste 2"}
  @params_invalido1 %{texto: "t", num: "1", buttons2: "Texto"}
  @params_invalido2 %{texto: "tes", num: "a", buttons2: "Texto"}

  describe "testes que passam com sucesso" do
    test "Test com params válidos" do
      changeset =
        NovosTestes.changeset(
          %NovosTestes{},
          @params_valido1
        )

      assert %{num: _, slug: _, texto: _} = changeset.changes
      assert changeset.errors == []
      assert changeset.valid?
    end

    test "test com num string número" do
      changeset =
        NovosTestes.changeset(
          %NovosTestes{},
          @params_valido2
        )

      assert %{num: 2, slug: _, texto: _} = changeset.changes
      assert [] = changeset.errors
      assert changeset.valid?
    end
  end

  describe "testes que geram erro" do
    test "test com params vazio" do
      changeset =
        NovosTestes.changeset(
          %NovosTestes{},
          %{}
        )

      errors = changeset.errors
      assert %{} = changeset.changes
      assert [texto: _, num: _, buttons2: _] = errors
      assert String.contains?(inspect(errors), ["can't be blank"])
      refute changeset.valid?
    end

    test "test com primeiro param inválido" do
      changeset =
        NovosTestes.changeset(
          %NovosTestes{},
          @params_invalido1
        )

      errors = changeset.errors
      assert %{} = changeset.changes
      assert [texto: _] = errors
      assert String.contains?(inspect(errors), ["should be at least"])
      refute changeset.valid?
    end

    test "test com num string letra" do
      changeset =
        NovosTestes.changeset(
          %NovosTestes{},
          @params_invalido2
        )

      errors = changeset.errors
      assert %{slug: _, texto: _} = changeset.changes
      assert [num: _] = errors
      assert String.contains?(inspect(errors), ["is invalid"])
      refute changeset.valid?
    end
  end
end
