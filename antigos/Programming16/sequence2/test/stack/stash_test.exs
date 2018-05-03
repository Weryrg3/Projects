defmodule Stack.StashTest do
  use ExUnit.Case

  test "Teste para saber se o GenServer iniciou" do
    test = assert Stack.Stash.start_link("args")

    assert elem(test, 0) == :error
    assert elem(test, 1) |> elem(0) == :already_started
    assert elem(test, 1) |> elem(1) |> is_pid()
    assert elem(test, 1) |> elem(1) |> Process.alive?()
  end

  test "Teste das Funções da API pública do Server" do
    assert Stack.Stash.get == [1, 2, 4, 3, 5]
    assert Stack.Stash.update(2) == :ok

  end
end
