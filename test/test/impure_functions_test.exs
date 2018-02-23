defmodule ImpureFunctionsTest do
  use ExUnit.Case

  test "Test de erro do With" do
    assert Test.ImpureFunctions.With.checkout0("10\n") == 20
    assert Test.ImpureFunctions.With.checkout0("aaa\n") == "Error wrong"
  end
end