defmodule TestStats do
  use ExUnit.Case

  describe "Teste de list ints" do
    setup do
      [list: [1, 2, 3, 4, 5], sum: 15, count: 5]
    end

    test "Calcula a soma", fixture do
      assert Test.Tooling.Stats.sum(fixture.list) == fixture.sum
    end

    test "Conta", fixture do
      assert Test.Tooling.Stats.count(fixture.list) == fixture.count
    end

    test "Média I think", fixture do
      assert Test.Tooling.Stats.average(fixture.list) == fixture.sum / fixture.count
    end
  end
end