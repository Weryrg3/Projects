defmodule Cinema.Video do
  use Cinema.Web, :model

  schema "videos" do
    field(:titulo, :string)
    field(:ano, :string)
    field(:sinopse, :string)
    field(:elenco, :string)
    field(:diretor, :string)
    field(:formato, :string)
    field(:duracao, :string)
    field(:trailer, :string)
    belongs_to(:user, Cinema.User)
    belongs_to(:categoria, Cinema.Categoria)
    belongs_to(:classificacao, Cinema.Classificacao)

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :titulo,
      :ano,
      :sinopse,
      :elenco,
      :diretor,
      :formato,
      :duracao,
      :trailer
    ])
    |> cast_assoc(:categoria)
    |> cast_assoc(:classificacao)
    # |> validate_required([
      # :titulo,
      # :categoria,
      # :classificacao,
      # :ano,
      # :sinopse,
      # :elenco,
      # :diretor,
      # :formato,
      # :duracao,
      # :trailer
    # ])
  end
end
