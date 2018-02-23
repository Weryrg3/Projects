defmodule ImpureFunctionsTest do
  use ExUnit.Case

  test "Test de erro do With" do
    assert Test.ImpureFunctions.With.checkout0(10) == 40
  end
end