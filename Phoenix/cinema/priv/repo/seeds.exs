# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cinema.Repo.insert!(%Cinema.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Cinema.Repo
alias Cinema.{Categoria, Classificacao}

for categoria <- ~w(Ação Animação Aventura Comédia Documentário Fantasia Faroeste Ficção-científica Guerra Musicais Romance Suspense Terror Drama) do
  Repo.get_by(Categoria, nome: categoria) || Repo.insert!(%Categoria{nome: categoria})
end

for classificacao <- ~w(L 10 12 14 16 18 ER) do
  Repo.get_by(Classificacao, nome: classificacao) || Repo.insert!(%Classificacao{nome: classificacao})
end
