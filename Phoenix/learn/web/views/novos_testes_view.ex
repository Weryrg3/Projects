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

  # def nomes(lista) do
  #   Enum.map(lista, & &1.texto)
  #   # |> Enum.join(" - ")
  # end

  def data(data_time) do
    data_time
    |> inspect()
    |> String.replace("~N[", "")
    |> String.split(".")
    |> List.first()
  end

  def alfabeto(lista) do
    lista
    |> Enum.sort_by(& &1.texto)
  end

  # def ordenar(map) do
  #   map
  #   |> Map.delete("cor")
  #   |> Enum.map(fn {v1, v2} -> {String.to_integer(v1), v2} end)
  #   |> Enum.sort()
  #   |> Enum.map(fn {v1, v2} -> {Integer.to_string(v1), v2} end)
  # end

  @doc "recebe um mapa e o ordena retornando uma lista"
  def ordenar(map) do
    # 123 Arrumar função sort e verificar erros
    # |> IO.inspect(limit: :infinity)
    # IO.inspect(Enum.count(map), limit: :infinity)
    map
    |> Map.delete("cor")
    |> Enum.map(fn {v1, v2} ->
      {
        v1
        |> String.to_float(),
        v2
      }
    end)
    |> Enum.sort()
    |> Enum.map(fn {v1, v2} ->
      {
        v1
        |> Float.to_string()
        |> String.split(".")
        |> (fn [f, l] ->
              [f, String.pad_trailing(l, 2, "0")]
            end).()
        |> Enum.join("."),
        v2
      }
    end)
  end
end
