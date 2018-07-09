defmodule Learn.Repo.Migrations.AddSlugNovosTestes do
  use Ecto.Migration

  def change do
    alter table(:novostestes) do
      add :slug, :string
    end
  end
end
