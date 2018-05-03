defmodule SendNumberTest do
  use ExUnit.Case
  doctest SendNumber

  test "greets the world" do
    assert SendNumber.hello() == :world
  end
end
