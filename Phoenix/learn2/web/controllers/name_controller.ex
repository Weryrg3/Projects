defmodule Learn2.NameController do
  use Learn2.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    changeset = Name.changeset(%Name{})
    render(conn, "new.html", changeset: changeset)
  end
end
