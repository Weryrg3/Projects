defmodule Learn.PartnStructTest do
  use ExUnit.Case
  # aliases usados para evitar error credo
  alias Learn.Struct2
  alias Learn.RequestStruct1
  alias Learn.PartnStruct

  test "Test de retorn da Struct all 0, fun1" do
    evit_credo_error = Enum.at(RequestStruct1.all(), 0)

    assert evit_credo_error
           |> PartnStruct.run(Struct2.fun1()) == {:ok, "Isadore"}
  end

  test "Test de retorn da Struct all 1, fun2" do
    evit_credo_error = Enum.at(RequestStruct1.all(), 1)

    assert evit_credo_error
           |> PartnStruct.run(Struct2.fun2()) ==
             {
               %Learn.Struct1{
                 age: 21,
                 atom: :test2,
                 name: "Jaqueline",
                 range: 1..10,
                 school: "Ifro",
                 stage: nil,
                 stronger: 26
               },
               :test3
             }
  end

  test "Test de retorn da Struct all 2, fun3" do
    evit_credo_error = Enum.at(RequestStruct1.all(), 2)

    assert evit_credo_error
           |> PartnStruct.run(Struct2.fun3()) == {:ok, 30}
  end
end
