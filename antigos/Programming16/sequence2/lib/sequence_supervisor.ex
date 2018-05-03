defmodule SequenceSupervisor do
  use Supervisor

  @me __MODULE__

  def start_link(args) do
    Supervisor.start_link(@me, args, name: @me)
  end

  def init(args) do
    children = [
      {Sequence2.Stash, args},
      {Sequence2.Server, nil}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

