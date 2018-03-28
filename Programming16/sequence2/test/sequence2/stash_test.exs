defmodule Sequence2.StashTest do
  use ExUnit.Case

  test "Teste para saber se o GenServer iniciou" do
    test = assert Sequence2.Stash.start_link("args")

    assert Sequence2.Stash.init(100) == {:ok, 100}
    assert elem(test, 0) == :error
    assert elem(test, 1) |> elem(0) == :already_started
    assert elem(test, 1) |> elem(1) |> is_pid()
    assert elem(test, 1) |> elem(1) |> Process.alive?()
  end

  test "Teste das Funções da API pública do Stash" do
    assert Sequence2.Stash.get == 500
    assert Sequence2.Stash.init(100) == {:ok, 100}
    assert Sequence2.Stash.update(20) == :ok
  end
end
