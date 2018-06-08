defmodule Learn.NovosTestes do
  use Learn.Web, :model

  schema "novostestes" do
    field(:texto, :string)
    field(:num, :integer)

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
  end
end
