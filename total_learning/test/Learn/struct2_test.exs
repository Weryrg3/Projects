defmodule Learn.Struct2Test do
  use ExUnit.Case
  alias Learn.Struct2

  test "Testando retorn da primeira função" do
    assert Struct2.fun1 == %Struct2{id: :first, string: "Primeira string."}
  end

  test "Testando retorn da segunda função" do
    assert Struct2.fun2 == %Struct2{id: :second, string: "Segunda string."}
  end

  test "Testando retorn da terceira função" do
    assert Struct2.fun3 == %Struct2{id: :third, string: "Terceira string."}
  end
end
