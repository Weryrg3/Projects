defmodule Learn.Repo.Migrations.CriarNomeButton do
  use Ecto.Migration

  def change do
    alter table(:relacionamentos) do
      add :nome, :string
    end
  end
end
