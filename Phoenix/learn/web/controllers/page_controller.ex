defmodule Learn.PageController do
  use Learn.Web, :controller

  # page_path GET / :index
  def index(conn, _params) do
    render conn, "index.html"
  end
end
