defmodule Cinema.Video do
  use Cinema.Web, :model

  schema "videos" do
    field :titulo, :string
    field :classificacao, :string
    field :ano, :string
    field :sinopse, :string
    field :elenco, :string
    field :genero, :string
    field :subgenero, :string
    field :diretor, :string
    field :formato, :string
    field :duracao, :string
    field :trailer, :string
    belongs_to :user, Cinema.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:titulo, :classificacao, :ano, :sinopse, :elenco, :genero, :subgenero, :diretor, :formato, :duracao, :trailer])
    |> validate_required([:titulo, :classificacao, :ano, :sinopse, :elenco, :genero, :subgenero, :diretor, :formato, :duracao, :trailer])
  end
end
