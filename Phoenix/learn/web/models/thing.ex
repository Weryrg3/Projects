defmodule Learn.Thing do
  use Learn.Web, :model

  schema "things" do
    field(:name, :string)
    field(:name2, :string)
    field(:name3, :string)
    field(:codigo, :string, virtual: true)
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name name2), [])
    |> validate_length(:name2, min: 3, max: 25)
    |> validate_required([:name, :name2])
  end
end
