defmodule Learn.Relacionamentos do
  @moduledoc """
  Schema dos Relacionamentos
  """
  use Learn.Web, :model
  alias Learn.NovosTestes

  schema "relacionamentos" do
    field(:campo, :string)
    field(:nome, :string)
    belongs_to(:novos_testes, NovosTestes)
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:campo, :nome])
    |> validate_required([:campo, :nome])
  end
end




