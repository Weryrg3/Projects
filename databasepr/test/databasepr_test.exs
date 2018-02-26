defmodule DatabaseprTest do
  use ExUnit.Case
  doctest Databasepr

  test "greets the world" do
    assert Databasepr.hello() == :world
  end
end
