defmodule Cinema.Repo.Migrations.CreateVideo do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add(:titulo, :string)
      add(:classificacao, :string)
      add(:ano, :string)
      add(:sinopse, :text)
      add(:elenco, :string)
      add(:genero, :string)
      add(:subgenero, :string)
      add(:diretor, :string)
      add(:formato, :string)
      add(:duracao, :string)
      add(:trailer, :string)
      add(:user_id, references(:users, on_delete: :nothing))

      timestamps()
    end

    create(index(:videos, [:user_id]))
  end
end
