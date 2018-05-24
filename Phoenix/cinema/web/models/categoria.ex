defmodule Cinema.Categoria do
  use Cinema.Web, :model

  schema "categorias" do
    field :nome, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nome])
    |> validate_required([:nome])
  end

  def alfabeto(query) do
    from c in query, order_by: c.nome
  end

  def nomes_e_ids(query) do
    from c in query, select: {c.nome, c.id}
  end
end
