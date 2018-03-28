defmodule Sequence2.ServerTest do
  use ExUnit.Case

  test "Teste para saber se o GenServer iniciou" do
    test = assert Sequence2.Server.start_link("args")

    # assert Sequence2.Server.init("args") == {:ok, 500}
    assert elem(test, 0) == :error
    assert elem(test, 1) |> elem(0) == :already_started
    assert elem(test, 1) |> elem(1) |> is_pid()
    assert elem(test, 1) |> elem(1) |> Process.alive?()
  end

  test "Teste das Funções da API pública do Server" do
    assert Sequence2.Server.next_number == 500
    assert Sequence2.Server.next_number == 501
    assert Sequence2.Server.increment_number(4) == :ok
    assert Sequence2.Server.next_number == 506
  end
end
