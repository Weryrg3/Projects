defmodule Conditions.Screen do
  def organize({:page_not_found, _body}), do: {:error, "Page not found"}
  def organize({:error, reason}), do: {:error, "Error reason #{reason}"}

  def organize({:ok, body}) do
    # -> Verificar depois, a atribuição parece acabar com Timeout do HTTPoison?? Why??
    test_body = body

    list =
      test_body
      |> String.replace(" ", "")
      |> String.trim()
      |> String.split("<location>")
      |> Enum.at(1)
      |> String.split("<icon")
      |> Enum.at(0)
      |> String.split()
      

    {:ok, list}
  end

  def show(list) do
    exclusion_list = exclusion()
    list
    |> Enum.map(&String.replace(&1, exclusion_list ,""))
  end

  def exclusion() do
    [
      "</location>", "<station", " ", "id>", "</station id>"
    ]
  end
end