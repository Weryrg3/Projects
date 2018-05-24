defmodule Cinema.Repo.Migrations.AddCategoriaIdVideo do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add(:categoria_id, references(:categorias))
    end
  end
end
