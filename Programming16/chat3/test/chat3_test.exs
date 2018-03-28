defmodule Chat3Test do
  use ExUnit.Case
  doctest Chat3

  test "greets the world" do
    assert Chat3.hello() == :world
  end
end
