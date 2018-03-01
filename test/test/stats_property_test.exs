defmodule StatsPropertyTest do
  use ExUnit.Case
  use ExUnitProperties
  alias Test.Tooling.Stats

  describe "Stats on lists of ints" do
    @tag :two
    property "count not negative" do
      check all l <- list_of(integer()) do
        assert Stats.count(l) >= 0
      end
    end

    @tag :two
    property "single element lists are their own sum" do
      check all number <- integer() do
        assert Stats.sum([number]) == number
      end
    end

    @tag :two
    property "sum equals average times count" do
      check all l <- list_of(integer()) |> nonempty do  #nonempty or min_length: 1
        assert_in_delta(Stats.sum(l), Stats.count(l) * Stats.average(l), 1.0e-6)
      end
    end
  end
end
