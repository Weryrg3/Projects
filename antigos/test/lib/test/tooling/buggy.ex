defmodule Test.Tooling.Buggy do
  def bug(int, float) do
    # require IEx; IEx.pry
    int
    |> String.to_integer()
    |> (&(&1 + String.to_float(float))).()
    |> sum()
  end

  defp sum(arg) do
    arg + 15.5
  end
end

# iex(1)> require IEx
# iex(2)> break! Test.Tooling.Buggy.bug/2
# iex(3)> breaks
# pry(1)> binding
# continue
