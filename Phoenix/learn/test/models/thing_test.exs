defmodule Learn.ThingTest do
  use Learn.ModelCase

  alias Learn.Thing

  @params_validos %{name: "teste", name2: "teste 2"}
  @params_invalido1 %{name: "teste", name2: "t"}
  @params_invalido2 %{name: 1, name2: "teste"}

  describe "teste com params válidos" do
    test "test com sucesso" do
      changeset =
        Thing.changeset(
          %Thing{},
          @params_validos
        )

      assert %{name: _, name2: _} = changeset.changes
      assert [] = changeset.errors
      assert changeset.valid?
    end
  end

  describe "teste com params inválidos" do
    test "test com param name2 inválido" do
      changeset =
        Thing.changeset(
          %Thing{},
          @params_invalido1
        )

      errors = changeset.errors
      assert %{} = changeset.changes
      assert [name2: _] = errors
      assert String.contains?(inspect(errors), ["should be at"])
      refute changeset.valid?
    end

    test "test com param name inválido com número" do
      changeset =
        Thing.changeset(
          %Thing{},
          @params_invalido2
        )

      errors = changeset.errors
      assert %{} = changeset.changes
      assert [name: _] = errors
      assert String.contains?(inspect(errors), ["is invalid"])
      refute changeset.valid?
    end
  end
end
