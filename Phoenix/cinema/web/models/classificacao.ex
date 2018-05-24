defmodule Cinema.Classificacao do
  use Cinema.Web, :model

  schema "classificacoes" do
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

  def ordenar(query) do
    from c in query, order_by: c.id
  end

  def nomes_e_ids(query) do
    from c in query, select: {c.nome, c.id}
  end
end
