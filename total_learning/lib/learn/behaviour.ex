defmodule Learn.Behaviour do
  @moduledoc "Este é um modulo de teste de behaviour"
  alias Learn.Struct1
  alias Learn.Struct2
  @callback run(Struct1.t(), Struct2.t()) :: {Struct2.t(), atom}
end
