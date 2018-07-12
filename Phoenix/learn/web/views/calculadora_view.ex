defmodule Learn.CalculadoraView do
  use Learn.Web, :view

  def handle(string) do
    if String.length(string) >= 3 do
      nums = String.split(string, ["+", "-", "*", "/", "x"])
      eq = Enum.join(nums)
      %{del: op} =
      string
      |> String.myers_difference(eq)
      |> Map.new()

      case Enum.map(nums, &Float.parse(&1)) do
        [{n1, _}, {n2, _}] ->
          "#{n1} #{op} #{n2} = #{operation(op, {n1, n2})}"
          _ -> "Argumento inválido!!"
      end
    else
      "#{string}"
    end
  end

  defp operation("+", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 + n2
  defp operation("-", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 - n2
  defp operation("/", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 / n2
  defp operation("*", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 * n2
  defp operation("x", {n1, n2}) when is_float(n1) and is_float(n2), do: n1 * n2
  defp operation(_, _), do: "Erro Operação inválida!!!"
end
