defmodule Learn.Repo.Migrations.CriarRelacionamentos do
  use Ecto.Migration

  def change do
    create table(:relacionamentos) do
      add(:campo, :string)
      add(:novos_testes_id, references(:novostestes, on_delete: :delete_all))
      timestamps()
    end
  end
end

