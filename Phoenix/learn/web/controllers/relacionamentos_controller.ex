defmodule Learn.RelacionamentosController do
  use Learn.Web, :controller

  # relacionamentos_path GET /relacionamentos :index
  def index(conn, _) do
    render(conn, "index.html")
  end
end

# relacionamentos_path GET /relacionamentos/:id/edit :edit
# relacionamentos_path GET /relacionamentos/new :new
# relacionamentos_path GET /relacionamentos/:id :show
# relacionamentos_path POST /relacionamentos :create
# relacionamentos_path PATCH /relacionamentos/:id :update
# relacionamentos_path PUT /relacionamentos/:id :update
# relacionamentos_path DELETE /relacionamentos/:id :delete

