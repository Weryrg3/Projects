defmodule Learn.Repo.Migrations.NovosTeste do
  use Ecto.Migration

  def change do
    create table("novoteste") do
      add(:texto, :string)
      add(:num, :integer)
      timestamps()
    end
  end
end
