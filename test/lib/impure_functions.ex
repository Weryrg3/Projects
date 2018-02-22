defmodule Test.ImpureFunctions do
  alias Mix.Shell.IO, as: Shell
  # use Monad.Operators não está funcionando 
  defmodule Try do
    def checkout0() do
      try do
        test = 
          Shell.prompt("Try -> checkout0")
          |> String.trim()
          |> String.to_integer()

        n0 = test0()
        n1 = test1(n0)
        n2 = test2(n1)
        # n2 * n1
        IO.puts(n2 + test)
      rescue
        # MatchError -> "No match"
        ArgumentError -> 
          Shell.info("Erro de argumento")
          checkout0()
        ArithmeticError -> 
          Shell.info("Erro de operação")
          checkout0()
      end
    end

    def checkout1() do
      test = Shell.prompt("Try -> checkout1")
      case Integer.parse(test) do
        :error ->
          raise Try.Try1

        _ ->
          Shell.info("messagem qualquer")
      end
    end

    def checkout2() do
      test = String.trim(Shell.prompt("Try -> checkout2"))
      Shell.info("test1 no test #{test}")
    end
    
    defp test0(), do: 1.0
    defp test1(num), do: num * 2
    defp test2(num), do: ([num] ++ [1, "1", "2"]) |> Enum.random()
    defmodule Try1, do: defexception message: "Erro geral bugou tudo"
  end
##################################################################################################################################
  defmodule Try2 do
    @invalid_option {:error, "Opção inválida"}
    
    def checkout0() do
      test1 = Shell.prompt("Try2 -> checkout0")
      case Integer.parse(test1) do
        :error ->
          throw @invalid_option # Está funcionando?
        _ ->
          Shell.info("Deu certo")
      end
    end
    
    def checkout1() do
      test2 = Shell.prompt("Try2 -> checkout1")
      test2
    end

    def checkout2() do
      test3 = Shell.prompt("Try2 -> checkout2")
      try do
        elem(Integer.parse(test3), 0)
        |> boolean()
      catch 
        {:error, message} ->  # Está funcionando?
          IO.puts("test1")
          Shell.error(message)
      end
    end

    def boolean(n) do
      IO.puts(n)
      throw @invalid_option
    end

  end
##################################################################################################################################
  defmodule Monad do
    # import Monad.Result, only: [success: 1, success?: 1, error: 1, return: 1]
    def checkout0(), do: "test apenas test1"  # use Monad.Operators não está funcionando 
    def checkout1(), do: "test apenas test2"  # use Monad.Operators não está funcionando 
    def checkout2(), do: "test apenas test3"  # use Monad.Operators não está funcionando 
  end

  defmodule With do
    def checkout0(), do: 1
    def checkout1(), do: 2
    def checkout2(), do: 3
  end
end