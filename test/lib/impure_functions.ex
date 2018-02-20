defmodule Test.ImpureFunctions do
  defmodule Try do
    def checkout() do
      try do
        n0 = test0()
        n1 = test1(n0)
        n2 = test2(n1)
        n2 * n1
      rescue
        MatchError -> "Não é um número"
      end
    end

    def test0(), do: 1.0
    def test1(num), do: num * 2
    def test2(num), do: ([num] ++ [1, "1", "2"]) |> Enum.random()
  end
end