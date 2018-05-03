defmodule Learn.RequestStruct1Test do
  use ExUnit.Case
  alias Learn.RequestStruct1

  test "Verifica o retorn da função all (structs)" do
    assert RequestStruct1.all() == [
             %Learn.Struct1{
               age: 17,
               name: "Isadore",
               range: 1..5,
               school: "Unijipa",
               stage: nil,
               stronger: 20,
               atom: :test1
             },
             %Learn.Struct1{
               age: 21,
               name: "Jaqueline",
               range: 1..10,
               school: "Ifro",
               stage: nil,
               stronger: 26,
               atom: :test2
             },
             %Learn.Struct1{
               age: 30,
               name: "Gloria",
               range: 1..4,
               school: "Ulbra",
               stage: nil,
               stronger: 15,
               atom: :test1
             }
           ]
  end
end
