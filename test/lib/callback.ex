# defmodule Test.Callback do
  # @callback run(arg :: String.t) :: integer
# end

defmodule Test.Callback do
  @behaviour Test.Behaviour
  def my_fun(arg), do: arg * 10
end

defmodule Tes1 do
  @behaviour Test.Behaviour
  def my_fun(arg), do: arg * 11
end

defmodule Tes2 do
  @behaviour Test.Behaviour
  def my_fun(arg), do: arg + 2
end

defmodule Tes3 do
  @behaviour Test.Behaviour
  def my_fun(arg), do: arg * 2
end

defmodule Tes4 do
  @behaviour Test.Behaviour
  def my_fun(arg), do: arg - 2
end