defmodule Cinema3.Filme do
  use Cinema3.Web, :model
  @moduledoc """
  Schema de filmes e changesets
  """

  schema "filmes" do
    field(:nome, :string)
    field(:ano, :string)
    field(:sinopse, :string)
    field(:elenco, :string)
    field(:formato, :string)
    field(:duracao, :string)
    field(:categoria, :string)
    field(:classificacao, :string)
    belongs_to(:usuario, Cinema3.Usuario)
    timestamps()
  end

  @allowed ~w(nome ano sinopse elenco formato duracao categoria classificacao)a

  def changeset(model, filme_params \\ %{}) do
    model
    |> cast(filme_params, @allowed)
    |> validate_required(@allowed)
    |> validate_length(:ano, is: 6)
    |> unique_constraint(:usuario_id)
    |> unique_constraint(:nome)
  end
end
