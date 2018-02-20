defmodule TestBehaviour do
  use ExUnit.Case
  #doctest Test

  test "Chamada callback" do
    assert Test.Behaviour.run(1) === 1
    assert Test.Behaviour.run(2) === 3
    assert Test.Behaviour.test0() === 1
  end
end