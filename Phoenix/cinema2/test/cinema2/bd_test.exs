defmodule Cinema2.BDTest do
  use Cinema2.{ModelCase, Usuario, BD}

  describe "BD usuario" do
    test "inserir valor null no BD" do
      assert BD.inserir_usuario(%{})
    end
  end
end
