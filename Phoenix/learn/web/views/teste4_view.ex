defmodule Learn.Teste4View do
  use Learn.Web, :view

  def handle(string) do
    nums = String.split(string, ["+", "-", "*", "/", "x"])
    eq = Enum.join(nums)
    %{del: op} = String.myers_difference(string, eq) |> Map.new()
    [{n1, _}, {n2, _}] = Enum.map(nums, &Float.parse(&1))

    "#{n1} #{op} #{n2} = #{operation(op, {n1, n2})}"
  end

  defp operation("+", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 + n2
  defp operation("-", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 - n2
  defp operation("/", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 / n2
  defp operation("*", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 * n2
  defp operation("x", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 * n2
  defp operation(_, _), do: "Erro Operação inválida!!!"
end
