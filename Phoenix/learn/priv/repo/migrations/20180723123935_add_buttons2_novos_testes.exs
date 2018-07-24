defmodule Learn.Repo.Migrations.AddButtons2NovosTestes do
  use Ecto.Migration

  def change do
    alter table(:novostestes) do
      add(:buttons2, :text)
    end
  end
end
