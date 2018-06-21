defmodule Learn.NovosTestesView do
  use Learn.Web, :view

  @string [
    "primary",
    "danger",
    "success",
    "info",
    "warning"
  ]

  def random(arg) do
    case arg do
      "random" -> Enum.random(@string)
      _ -> arg
    end
  end

  def trocar_cor(cor) do
    case cor do
      "default" -> "primary"
      "primary" -> "danger"
      "danger" -> "success"
      "success" -> "info"
      "info" -> "warning"
      "warning" -> "primary"
    end
  end

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

  def relacionamentos([]) do
    ""
  end

  def relacionamentos([param]) do
    "Relacionamentos: #{param.campo}"
  end
end
