defmodule Learn.NovosTestes do
  use Learn.Web, :model
  alias Learn.Relacionamentos

  @primary_key {:id, Learn.Permalink, autogenerate: true}
  schema "novostestes" do
    field(:texto, :string)
    field(:num, :integer)
    field(:slug, :string)
    has_many(:relacionamentos, Relacionamentos)

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:texto, :num])
    |> slug()
    |> validate_required([:texto, :num])
    |> validate_number(
      :num,
      greater_than_or_equal_to: 1,
      less_than: 100
    )
    |> validate_length(:texto, min: 3, max: 500)
    |> unique_constraint(:texto)
  end

  defp slug(changeset) do
    if texto = get_change(changeset, :texto) do
      put_change(changeset, :slug, slug2(texto))
    else
      changeset
    end
  end

  defp slug2(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end

defimpl Phoenix.Param, for: Learn.NovosTestes do
  def to_param(%{slug: slug, id: id}) do
    "#{id}-#{slug}"
  end
end
