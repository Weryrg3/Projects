defmodule Chat4Test do
  use ExUnit.Case
  doctest Chat4

  test "greets the world" do
    assert Chat4.hello() == :world
  end
end
