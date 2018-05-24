defmodule Cinema.Repo.Migrations.AddClassificacaoIdVideo do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add(:classificacao_id, references(:classificacoes))
    end
  end
end
