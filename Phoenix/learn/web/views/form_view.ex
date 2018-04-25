defmodule Learn.FormView do
  use Learn.Web, :view

  def len_list(list) do
    Enum.count(list)
  end
end
