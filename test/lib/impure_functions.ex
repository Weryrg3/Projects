defmodule Test.ImpureFunctions do
  #import Monad.Result, only: [success: 1, success?: 1, error: 1, return: 1]
  alias Mix.Shell.IO, as: Shell
  use Monad.Operators 
  defmodule Try do
    def checkout0(arg) do
      try do
        Shell.info("Try -> checkout0 #{arg}")
        test =
          arg
          |> String.trim()
          |> String.to_integer()

        n0 = test0()
        n1 = test1(n0)
        n2 = test2(n1)
        # n2 * n1
        n2 + test
      rescue
        # MatchError -> "No match"
        ArgumentError -> 
          "Erro de argumento"
        ArithmeticError -> 
          "Erro de operação"
      end
    end

    def checkout1(arg) do
      Shell.info("Try -> checkout1 #{arg}")
      case Integer.parse(arg) do
        :error ->
          raise Try.Try1

        _ ->
          "messagem qualquer"
      end
    end

    def checkout2(arg) do
      Shell.info("Try -> checkout2 #{arg}")
      test = String.trim(arg)
      "test1 no test #{test}"
    end
    
    defp test0(), do: 1.0
    defp test1(num), do: num * 2
    defp test2(num), do: if rem(num, 2) == 0, do: "1", else: 2
    defmodule Try1, do: defexception message: "Erro geral bugou tudo"
  end
##################################################################################################################################
  defmodule Try2 do
    @invalid_option {:error, "Opção inválida"}
    
    def checkout0(arg) do
      Shell.info("Try2 -> checkout0 #{arg}")
      case Integer.parse(arg) do
        :error ->
          throw @invalid_option # "Joga" uma função para catch pegar
        _ ->
          "Deu certo"
      end
    end
    
    def checkout1(arg) do
      test2 = Shell.info("Try2 -> checkout1 #{arg}")
      test2
    end

    def checkout2(arg) do
      Shell.info("Try2 -> checkout2 #{arg}")
      try do
        elem(Integer.parse(arg), 0)
        |> boolean()
      catch 
        {:error, message} ->  #Só funciona se o catch pegar um throw
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
    # Monad difícil estudar mais 
    def checkout0(arg), do: "Monad não está sendo usado ainda #{arg}"
    def checkout1(arg), do: "Monad não está sendo usado ainda #{arg}"
    def checkout2(arg), do: "Monad não está sendo usado ainda #{arg}"
  end

  defmodule With do
    def checkout0(arg) do 
      Shell.info("With -> checkout0 #{arg}")
      result = 
        with {n, _} <- Integer.parse(arg), #do: n
             num <- n + 10, do: num
        if result == :error, do: "Error wrong", else: result
    end
    def checkout1(arg) do
      Shell.info("With -> checkout1 #{arg}")
        with {n, _} <- Integer.parse(arg),
          #:error <- Integer.parse(test2),
          num <- n + 10 do
            num * 2
          else
            :error -> "Error wrong"
          end
    end
    def checkout2(arg) do
      # test3 = Shell.prompt("With -> checkout2")
      Shell.info("With -> checkout2 #{arg}")
    end
  end
end