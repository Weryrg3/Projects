defmodule ImpureFunctions.CLI do
  alias Test.ImpureFunctions
  alias Mix.Shell.IO
  # def start(), do: Enum.random([Try.checkout(), Try.checkout1()])
  def start() do
    IO.info("Modulos: \n1 - Try \n2 - Try2\n3 - Monad\n4 - With")
    module = number()
    IO.info("Funções: \n1 - checkout0 \n2 - checkout1\n3 - checkout2")
    function = number()
    mods(module, function-1).()
  end

  defp mods(1, fun), do: elem({&ImpureFunctions.Try.checkout0/0,   &ImpureFunctions.Try.checkout1/0,   &ImpureFunctions.Try.checkout2/0}, fun)
  defp mods(2, fun), do: elem({&ImpureFunctions.Try2.checkout0/0,  &ImpureFunctions.Try2.checkout1/0,  &ImpureFunctions.Try2.checkout2/0}, fun)
  defp mods(3, fun), do: elem({&ImpureFunctions.Monad.checkout0/0, &ImpureFunctions.Monad.checkout1/0, &ImpureFunctions.Monad.checkout2/0}, fun)
  defp mods(4, fun), do: elem({&ImpureFunctions.With.checkout0/0,  &ImpureFunctions.With.checkout1/0,  &ImpureFunctions.With.checkout2/0}, fun)

  defp number() do
    parse = fn {n, _} -> n end
    IO.prompt("Escolha um número:")
      |> Integer.parse()
      |> parse.()
  end
end