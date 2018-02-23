defmodule ImpureFunctionsTest do
  use ExUnit.Case

  test "Test de erro Try" do
    assert Test.ImpureFunctions.Try.checkout0("10\n") == "Erro de operação"
    assert Test.ImpureFunctions.Try.checkout0("15\n") == 17
    assert Test.ImpureFunctions.Try.checkout0("aaa\n") == "Erro de argumento"

    assert Test.ImpureFunctions.Try.checkout1("10\n") == "mensagem qualquer"
    # assert Test.ImpureFunctions.Try.checkout1("aaa\n") == raise "Erro geral bugou tudo"
    assert Test.ImpureFunctions.Try.checkout2("10\n") == "test1 no test 10"
    
  end

  test "Test de erro do Try2" do
    assert Test.ImpureFunctions.Try2.checkout0("10\n") == "Deu certo"
    #assert Test.ImpureFunctions.Try2.checkout0("aaa\n") == "Deu certo"
    assert Test.ImpureFunctions.Try2.checkout1("10\n") == "10\n"
    assert Test.ImpureFunctions.Try2.checkout2("10\n") == :ok
  end
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