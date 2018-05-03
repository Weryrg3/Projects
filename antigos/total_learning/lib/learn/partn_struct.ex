defmodule Learn.PartnStruct do
  @behaviour Learn.Behaviour
  @moduledoc "Testa partned match de structs"

  @doc """
  Essa função irá testar partned match de chamada
  de função e behaviour de retorno e entrada.
  """
  def run(struct, %Learn.Struct2{string: "Segunda string."}), do: {struct, :test3}

  @doc """
  Essa função irá testar partned match de chamada
  de função e behaviour de retorno e entrada.
  """
  def run(struct, %Learn.Struct2{string: "Primeira string."}), do: {:ok, struct.name}

  @doc """
  Essa função irá testar partned match de chamada
  de função e behaviour de retorno e entrada.
  """
  def run(struct, %Learn.Struct2{string: "Terceira string."}), do: {:ok, struct.age}
end
