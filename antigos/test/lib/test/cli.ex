defmodule ImpureFunctions.CLI do
  alias Test.ImpureFunctions
  alias Mix.Shell.IO, as: Shell
  # def start(), do: Enum.random([Try.checkout(), Try.checkout1()])
  def start() do
    selected_module = modules()
    selected_function = functions(selected_module)
    arg = Shell.prompt("Entre com um argumento qualquer")
    IO.puts(selected_function.(arg))
  end

  defp number() do
    Shell.prompt("Escolha um número:")
    |> Integer.parse()
    |> case do
      :error ->
        Shell.info("Erro número inválido")
        number()

      {n, _} ->
        n
    end
  end

  defp modules() do
    Shell.info("Modulos: \n1 - Try \n2 - Try2\n3 - Monad\n4 - With")
    module = number()

    case module do
      1 ->
        ImpureFunctions.Try

      2 ->
        ImpureFunctions.Try2

      3 ->
        ImpureFunctions.Monad

      4 ->
        ImpureFunctions.With

      _ ->
        Shell.info("Opção inválida\n")
        modules()
    end
  end

  defp functions(selected_module) do
    Shell.info("Funções: \n1 - checkout0 \n2 - checkout1\n3 - checkout2")
    function = number()

    case function do
      0 ->
        start()

      1 ->
        &selected_module.checkout0/1

      2 ->
        &selected_module.checkout1/1

      3 ->
        &selected_module.checkout2/1

      _ ->
        Shell.info("Opção inválida\nCaso tenha errado o módulo digite 0\n")
        functions(selected_module)
    end
  end
end
