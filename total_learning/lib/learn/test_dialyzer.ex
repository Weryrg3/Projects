defmodule Learn.TestDialyzer do
  alias Learn.Struct2
  @spec test1 :: Struct2.t()
  @moduledoc "Nesse módulo contem todos
  testes que irão passar pelo dialyzer
  onde, é tentado usar função de type
  differents."
  def test1 do
    %Struct2{id: :atom, string: "string2"}
    # Erro de type no dialyzer mix e ls.
    # %Struct2{id: "string", string: "string2"}
  end
end
