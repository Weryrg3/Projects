defmodule Learn.PageController do
  use Learn.Web, :controller

  @position Enum.map(1..13, fn i -> Enum.map(1..13, fn a -> "#{i}-#{a}" end) end)
  |> List.flatten()
  |> Map.new(fn x -> {x, "btn btn-default"} end)
  # page_path GET / :index

  def index(conn, _params) do
    conn
    |> render("index.html", position: @position)
  end
end
