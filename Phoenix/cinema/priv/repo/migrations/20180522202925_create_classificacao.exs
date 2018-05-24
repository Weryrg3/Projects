defmodule Cinema.Repo.Migrations.CreateClassificacao do
  use Ecto.Migration

  def change do
    create table(:classificacoes) do
      add(:nome, :string, null: false)

      timestamps()
    end

    create(unique_index(:classificacoes, [:nome]))
  end
end
