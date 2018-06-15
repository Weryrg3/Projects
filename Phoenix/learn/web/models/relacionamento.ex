defmodule Learn.Relacionamentos do
  use Learn.Web, :model
  alias Learn.NovosTestes

  schema "relacionamentos" do
    field(:campo, :string)
    belongs_to(:novostestes, NovosTestes)
    timestamps()
  end
end
