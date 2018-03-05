defmodule ConcurrentProgrammingTest do
  use ExUnit.Case
  doctest ConcurrentProgramming

  test "greets the world" do
    assert ConcurrentProgramming.hello() == :world
  end
end
