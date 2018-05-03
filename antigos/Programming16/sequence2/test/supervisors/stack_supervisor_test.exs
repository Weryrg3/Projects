defmodule StackSupervisorTest do
  use ExUnit.Case

  test "Teste para saber se o StackSupervisor iniciou" do
    test = StackSupervisor.start_link("arg")
    assert elem(test, 0) == :error
    assert elem(test, 1) |> elem(0) == :already_started
    assert elem(test, 1) |> elem(1) |> is_pid()
    assert elem(test, 1) |> elem(1) |> Process.alive?()
  end
end
