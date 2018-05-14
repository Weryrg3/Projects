ExUnit.start(exclude: [:pending])
# TODO desatviar eclude: ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Cinema.Repo, :manual)

