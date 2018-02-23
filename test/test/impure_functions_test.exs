defmodule ImpureFunctionsTest do
  use ExUnit.Case

  test "Test de erro Try" do
    assert Test.ImpureFunctions.Try.checkout0("10\n") == "Erro de operação"
    assert Test.ImpureFunctions.Try.checkout0("15\n") == "Erro de"
    assert Test.ImpureFunctions.Try.checkout0("aaa\n") == "Erro de argumento"
    
  end
# 
  # test "Test de erro do Try2" do
  # 
  # end
  # 
  # test "Test de erro do Monad" do
  # 
  # end
  test "Test de erro do With" do
    assert Test.ImpureFunctions.With.checkout0("10\n") == 20
    assert Test.ImpureFunctions.With.checkout0("aaa\n") == "Error wrong"
    
    assert Test.ImpureFunctions.With.checkout1("10\n") == 40
    assert Test.ImpureFunctions.With.checkout1("bbb\n") == "Error wrong"

    #assert Test.ImpureFunctions.With.checkout2("10\n") == 40
    #assert Test.ImpureFunctions.With.checkout2("bbb\n") == "Error wrong"
  end
end