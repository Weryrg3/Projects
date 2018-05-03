defmodule TaskAgentTest do
  use ExUnit.Case
  doctest TaskAgent

  test "greets the world" do
    assert TaskAgent.hello() == :world
  end
end
