defmodule ImpureFunctionsTest do
  use ExUnit.Case

  test "Teste de valores corretos" do
    assert Test.ImpureFunctions.Try.checkout() == 1
    assert Test.B
end