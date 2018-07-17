defmodule Learn.JavaScriptController do
  use Learn.Web, :controller
  # java_script_path GET /javascript :index
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
