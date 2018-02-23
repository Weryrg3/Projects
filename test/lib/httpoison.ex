defmodule Test.Httpoison do
  @test [{"User-agent", "Elixir dave@prgaprog.com"}]

  def test1(user, project) do
   test_url(user, project)
    |> HTTPoison.get(@test)
    |> resposta()
  end
  
  defp test_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def resposta({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end
  def respost({_, %{status_code: _, body: body}}) do
    {:error, body}
  end
end
