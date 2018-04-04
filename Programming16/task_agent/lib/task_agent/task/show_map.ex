defmodule TaskAgent.Task.ShowMap do
  use Task
  alias TaskAgent.Agent.Map, as: Agent

  def start_link(map) do
    Task.start_link(__MODULE__, :init, [map])
  end

  def init(map) do
    Agent.start_link(map)
  end

  def show(map) do
    map
    |> Enum.map(& &1)
    |> Enum.each(&IO.inspect(&1))

    map
  end

  def size(map) do
    map
      |> Map.keys
      |> length()
      |> IO.inspect()
  end

  def kill do
    Process.exit(self(), :kill)
  end
end
