defmodule NovoTest do
  use ExUnit.Case
  doctest Novo

  test "greets the world" do
    assert Novo.hello() == :world
  end
end
