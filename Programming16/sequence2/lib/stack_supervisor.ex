defmodule StackSupervisor do
  use Supervisor

  @me __MODULE__

  def start_link(args) do
    Supervisor.start_link(@me, args, name: @me)
  end

  def init(args) do
    children = [
      {Stack.Stash, args},
      {Stack.Server, [nil]}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
