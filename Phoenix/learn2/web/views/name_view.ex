defmodule Learn2.NameView do
  use Learn2.Web, :view

  def show(list) do
    Enum.map(list, fn map -> map.name end)
  end
end
