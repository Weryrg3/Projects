defmodule Cinema3.Repo.Migrations.CriarUsuario do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add(:username, :string)
      add(:nome, :string)
      add(:cpf, :string)
      add(:rg, :string)
      add(:endereco, :string)
      add(:telefone, :string)
      add(:senha_hash, :string)
      timestamps()
    end

    create(unique_index(:usuarios, [:username]))
    create(unique_index(:usuarios, [:cpf]))
    create(unique_index(:usuarios, [:rg]))
  end
end
