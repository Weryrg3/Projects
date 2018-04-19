defmodule Learn.Teste4Controller do
  use Learn.Web, :controller

  def teste4(conn, %{"name" => name}) do
    render(conn, "teste4.html", name: name)
  end
end
