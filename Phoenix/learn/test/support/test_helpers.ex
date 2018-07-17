defmodule Learn.TestHelpers do
  @moduledoc false
  alias Learn.{
    NovosTestes,
    Relacionamentos,
    Repo,
    Thing
  }

  def thing(params \\ %{}) do
    Map.merge(
      %{
        name: "name teste",
        name2: "name2 teste",
        name3: "name3 teste"
      },
      params
    )
  end

  def relacionamento(params \\ %{}) do
    Map.merge(
      %{
        nome: "nome teste",
        campo: "13x13"
      },
      params
    )
  end

  def novos_testes(params \\ %{}) do
    Map.merge(
      %{
        texto: "texto teste",
        num: 1
      },
      params
    )
  end

  def insert_thing(params \\ %{}) do
    changeset =
      Map.merge(
        %{
          name: "name teste",
          name2: "name2 teste",
          name3: "name3 teste"
        },
        params
      )

    insert_bd(Thing, changeset)
  end

  def insert_relacionamentos(params \\ %{}) do
    changeset =
      Map.merge(
        %{
          nome: "nome teste",
          campo: "campo teste"
        },
        params
      )

    insert_bd(Relacionamentos, changeset)
  end

  def insert_novos_testes(params \\ %{}) do
    changeset =
      Map.merge(
        %{
          texto: "texto teste",
          num: 1
        },
        params
      )

    insert_bd(NovosTestes, changeset)
  end

  defp insert_bd(schema, params) do
    struct!(schema)
    |> schema.changeset(params)
    |> Repo.insert!()
  end

  def get_bd(schema, id) do
    Repo.get(schema, id)
  end

  def get_bd_by(schema, arg) do
    Repo.get_by(schema, arg)
  end

  def has_in_bd?(schema) do
    if length(Repo.all(schema)) == 0 do
      false
    else
      true
    end
  end

  def preload_in_bd(struct, atom) do
    Repo.preload(struct, atom)
  end
end
