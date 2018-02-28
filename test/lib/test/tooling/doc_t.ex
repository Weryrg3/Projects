defmodule Test.Tooling.DocT do
  @moduledoc "Este module é apenas para teste de teste no mix chamado test sendo testado"

  @doc """
  A função abaixo pega um número e retorna ele mais um
  ## Example
      iex> Test.Tooling.DocT.same_function(1)
      2
  """

  def same_function(int) do
    # apenas uma função para teste
    int + 1
  end

  @doc """
  A função abaixo pega um string e Upcase alem de 
  concaternar com o again?
  ## Example
     iex> Test.Tooling.DocT.again?("casa")
     "CASA again?"
  """
  def again?(string) do
    String.upcase(string) <> " again?"
  end
end

# mix test test/doc_t_test.exs
