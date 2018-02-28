defmodule Test.Sort do
  alias Mix.Shell.IO, as: Shell

  def sort(lista) do
    Shell.info("Escolha uma função para testar.")
    # Trasformar em & comercial depois
    lista
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} -> Shell.info("#{index} - #{option}") end)

    parse(lista)
  end

  defp parse(lista) do
    num = Shell.prompt("Digite o número da função escolhida:")

    case Integer.parse(num) do
      :error ->
        IO.puts("Digite um valor correto")
        parse(lista)

      _ ->
        num
    end
  end
end
