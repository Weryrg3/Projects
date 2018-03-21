defmodule Chat2Test do
  use ExUnit.Case
  doctest Chat2

  test "Modulo inicial" do
    assert Chat2.init_new_server() == :new_server
  end
end
