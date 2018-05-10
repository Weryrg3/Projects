defmodule Cinema.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string)
      add(:nome, :string)
      add(:cpf, :string)
      add(:rg, :string)
      add(:cartao, :string)
      add(:endereco, :string)
      add(:telefone, :string)
      add(:senha_hash, :string)
      add(:permission, :boolean)
      timestamps()
    end

    create(unique_index(:users, [:cpf]))
    create(unique_index(:users, [:rg]))
    create(unique_index(:users, [:username]))
  end
end

