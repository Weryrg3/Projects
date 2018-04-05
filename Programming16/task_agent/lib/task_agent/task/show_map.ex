defmodule TaskAgent.Task.ShowMap do
  use Task
  alias TaskAgent.Agent.Map, as: MapAgent
  alias TaskAgent.Task.ShowMap

  def start_link(map) do
    Task.start_link(__MODULE__, :init, [map])
  end

  def init(map) do
    MapAgent.start_link(map)
  end

  def show(map) do
    map
    |> Enum.map(& &1)
    |> Enum.each(&IO.inspect(&1))

    map
  end

  def size(map) do
    map
    |> Map.keys()
    |> length()
    |> IO.inspect()
  end

  def kill do
    ShowMap.kill_me()
  end

  def kill_me do
    Process.exit(self(), :kill)
  end
end
