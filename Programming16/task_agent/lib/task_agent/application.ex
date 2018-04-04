defmodule TaskAgent.Application do
  use Application

  alias TaskAgent.Task.{ShowList, ShowMap}
  alias TaskAgent.Supervisor.GenSupervisor

  def start(_type, arg) do
    children = [
      {ShowList, arg.list},
      {ShowMap, arg.map},
      {GenSupervisor, arg.num}
    ]

    opts = [strategy: :one_for_one, name: TaskAgent.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
