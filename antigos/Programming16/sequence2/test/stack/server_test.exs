defmodule Stack.ServerTest do
  use ExUnit.Case

  test "Teste para saber se o GenServer iniciou" do
    test = assert Stack.Server.start_link("args")

    assert elem(test, 0) == :error
    assert elem(test, 1) |> elem(0) == :already_started
    assert elem(test, 1) |> elem(1) |> is_pid()
    assert elem(test, 1) |> elem(1) |> Process.alive?()
  end

  test "Teste das Funções da API pública do Server" do
    assert Stack.Server.show == [1, 2, 4, 3, 5]
    assert Stack.Server.pop == 1
    assert Stack.Server.push(2) == :ok
  end
end
