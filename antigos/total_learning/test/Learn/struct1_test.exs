defmodule Learn.StructTest do
  alias Learn.Struct1
  use ExUnit.Case

  test "Teste de retorno Struct1" do
    assert Struct1.__struct__() == %Learn.Struct1{
             age: 0,
             name: nil,
             range: nil,
             school: nil,
             stage: nil,
             stronger: 0
           }
  end
end
