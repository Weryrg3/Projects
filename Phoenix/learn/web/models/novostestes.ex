defmodule Learn.NovosTestes do
  use Learn.Web, :model
  alias Learn.Relacionamentos

  schema "novostestes" do
    field(:texto, :string)
    field(:num, :integer)
    has_many(:relacionamentos, Relacionamentos)

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:texto, :num])
    |> validate_required([:texto, :num])
    |> validate_number(
      :num,
      greater_than_or_equal_to: 1,
      less_than: 100
    )
    |> validate_length(:texto, min: 3, max: 500)
    |> unique_constraint(:texto)
  end
end
