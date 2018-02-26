defmodule Databasepr.App do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [supervisor(Database.Repo, [])]

    opts = [strategy: :one_for_one, name: Databasepr.Supervisor]
    Supervisor.start_link(children, opts)
  end
end