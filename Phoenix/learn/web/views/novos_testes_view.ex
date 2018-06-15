defmodule Learn.NovosTestesView do
  use Learn.Web, :view

  def nomes(lista) do
    Enum.map(lista, & &1.texto)
    # |> Enum.join(" - ")
  end

  def data(data_time) do
    inspect(data_time)
    |> String.replace("~N[", "")
    |> String.split(".")
    |> List.first()
  end

  def alfabeto(lista) do
    lista
    |> Enum.sort_by(& &1.texto)
  end
end
