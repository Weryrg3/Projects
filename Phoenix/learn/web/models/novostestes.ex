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
      less_than: 1,
      greater_than_or_equal_to: 100
    )
    |> validate_length(:texto, min: 3, max: 500)
  end
end
