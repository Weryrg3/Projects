defmodule Cinema3.Repo.Migrations.CriarFilme do
  use Ecto.Migration

  def change do
    create table(:filmes) do
      add(:nome, :string)
      add(:ano, :string)
      add(:sinopse, :string)
      add(:elenco, :string)
      add(:formato, :string)
      add(:duracao, :string)
      add(:categoria, :string)
      add(:classificacao, :string)
      add(:usuario_id, references(:usuarios, on_delete: :nothing))
      timestamps()
    end

    create(index(:filmes, [:usuario_id]))
    create(index(:filmes, [:nome, :ano]))
  end
end
