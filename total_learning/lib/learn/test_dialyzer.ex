defmodule Learn.TestDialyzer do
  alias Learn.Struct2
  @moduledoc "Nesse módulo contem todos
  testes que irão passar pelo dialyzer
  onde, é tentado usar função de type
  differents."
  def test1 do
    %Struct2{id: "string1", string: "string2"}
  end
end