defmodule Learn2.Repo.Migrations.Name do
  use Ecto.Migration

  def change do
    create table(:names) do
      add :name, :string
      timestamps()
    end
  end
end
