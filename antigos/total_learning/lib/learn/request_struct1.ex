defmodule Learn.RequestStruct1 do
  alias Learn.Struct1
  @moduledoc "Esse módulo requisita a struct1
  passando argumentos da função a seguir."

  @doc """
    A função abaixo é uma função que apenas retorna
    nesse caso uma lista de structs.
    o test aqui ficaria muito grande estão deduzi
    por não faze-lo nesse doc-test porém o test está
    feito em Learn.RequestStruct1Test
  """
  def all,
    do: [
      %Struct1{
        name: "Isadore",
        age: 17,
        school: "Unijipa",
        stronger: 20,
        range: 1..5,
        atom: :test1
      },
      %Struct1{
        name: "Jaqueline",
        age: 21,
        school: "Ifro",
        stronger: 26,
        range: 1..10,
        atom: :test2
      },
      %Struct1{
        name: "Gloria",
        age: 30,
        school: "Ulbra",
        stronger: 15,
        range: 1..4,
        atom: :test1
      }
    ]
end
