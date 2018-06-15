defmodule Learn.Repo.Migrations.CriarRelacionamentos do
  use Ecto.Migration

  def change do
    create table(:relacionamentos) do
      add(:campo, :string)
      add(:novostestes_id, references(:novostestes, on_delete: :nothing))
      timestamps()
    end

    create(unique_index(:relacionamentos, [:campo]))
    create(unique_index(:relacionamentos, [:novostestes_id]))
  end
end
