defmodule Pro16.HttPoison do
  @moduledoc "Esse módulo é apenas um test para HttPoison"

  @doc "Essa função faz um request do site com dados passsados"
  def request_http(user \\ "Weryrg3", project \\ "Projects") do
    HTTPoison.get("https://github.com/#{user}/#{project}")
    |> htt_body()
  end

  defp htt_body({:ok, %{status_code: 200, body: body}}), do: {:ok, Poison.decode(body)}
  defp htt_body({_, %{status_code: _, body: body}}), do: {:error, Poison.decode(body)}
end
