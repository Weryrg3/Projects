defmodule Test.Behaviour do
  @callback my_fun(arg :: any) :: integer
end

# defmodule Test.Behaviour do
#   @behaviour Test.Callback
#   def test0(), do: run("1")

#   def run(arg) do
#     if arg == 2 do
#       3
#     else
#       1
#     end
#   end
# end