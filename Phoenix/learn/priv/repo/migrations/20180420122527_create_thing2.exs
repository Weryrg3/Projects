defmodule Learn.Repo.Migrations.CreateThing2 do
  use Ecto.Migration

  def change do
    create table(:things) do
      add(:name, :string)
      add(:name2, :string)
      add(:name3, :string)
      add(:codigo, :string, virtual: true)
      timestamps()
    end
    create(unique_index(:things, [:codigo]))
  end
end
