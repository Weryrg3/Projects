defmodule Test.Tooling.Stats do
  def sum(numbers), do: numbers |> Enum.reduce(0, &+/2)
  def count(numbers), do: numbers |> Enum.count()
  def average(numbers), do: sum(numbers) / count(numbers)
end
