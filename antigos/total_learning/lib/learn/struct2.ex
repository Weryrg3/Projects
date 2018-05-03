defmodule Learn.Struct2 do
  alias Learn.Struct2
  @moduledoc "Esse modulo é apenas um struct simples para testes
  Essa struct contem apenas dois valores default apenas para test
  Para mais info de types https://hexdocs.pm/elixir/typespecs.html
  "
  defstruct string: nil, id: nil

  @type t :: %Struct2{id: atom, string: String.t()}

  @doc """
  Função1 que não recebe argumento, porém ao ser chamada retorna
  uma `struct` com um `atom` e uma `string`
  ## Examples
    iex> Learn.Struct2.fun1
    %Learn.Struct2{id: :first, string: "Primeira string."}
  """
  def fun1, do: %Struct2{id: :first, string: "Primeira string."}

  @doc """
  Função2 que não recebe argumento, porém ao ser chamada retorna
  uma struct com um atom e uma string
  ## Examples
    iex> Learn.Struct2.fun2
    %Learn.Struct2{id: :second, string: "Segunda string."}
  """
  def fun2, do: %Struct2{id: :second, string: "Segunda string."}

  @doc """
  Função3 que não recebe argumento, porém ao ser chamada retorna
  uma struct com um atom e uma string
  ## Examples
    iex> Learn.Struct2.fun3
    %Learn.Struct2{id: :third, string: "Terceira string."}
  """
  def fun3, do: %Struct2{id: :third, string: "Terceira string."}

  # Essa implementção, implementa o protocol String Já existente...
  defimpl String.Chars do
    def to_string(struct2), do: struct2.string
  end
end
