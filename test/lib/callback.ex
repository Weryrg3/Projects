# defmodule Test.Callback do
  # @callback run(arg :: String.t) :: integer
# end

defmodule Test.Callback do
  @behaviour Test.Behaviour
  def my_fun(arg), do: arg * 10
end