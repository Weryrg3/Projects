defmodule Learn.NovosTestesView do
  use Learn.Web, :view

  def nomes(lista) do
    Enum.map(lista, &(&1.texto))
    # |> Enum.join(" - ")
  end
end
