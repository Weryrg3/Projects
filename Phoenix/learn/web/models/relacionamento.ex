defmodule Learn.Relacionamentos do
  use Learn.Web, :model
  alias Learn.NovosTestes

  schema "relacionamentos" do
    field(:campo, :string)
    belongs_to(:novos_testes, NovosTestes)
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:campo])
    |> validate_required([:campo])
  end
end
