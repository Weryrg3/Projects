defmodule Learn.Struct1 do
  @moduledoc "Esse modulo condiz por testar
  a estrutura de um programa ou struct (default)
  onde o que é usado aqui está no livro Learn.\n
  Para mais info de types https://hexdocs.pm/elixir/typespecs.html"

  @doc "Uma simples struct para testes de aprendizado
  posteriormente."

  defstruct name: nil,
            age: 0,
            school: nil,
            stage: nil,
            stronger: 0,
            range: nil,
            atom: nil

  # @type -> TypeSpecs definindo o tipo de cada váriavel
  # da struct, irá dar erro apenas em programs exteriores
  # como dialyzer
  @type t :: %Learn.Struct1{
          name: String.t(),
          age: non_neg_integer,
          school: String.t(),
          stage: String.t(),
          stronger: non_neg_integer,
          range: Range.t(),
          atom: atom
        }
end

# b = %Learn.Struct1{
# name: "wesley",
# age: 20, school: "ULBRA",
# stage: "Eficiencia",
# stronger: 10,
# range: 1..5
# }
