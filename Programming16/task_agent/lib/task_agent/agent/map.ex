defmodule TaskAgent.Agent.Map do
  alias TaskAgent.Task.ShowMap
  # alias TaskAgent.Agent.Map, as: MapAgent

  def start_link(map) do
    Agent.start_link(fn -> map end, name: __MODULE__)
  end

  def add_elem(key, elem) do
    Agent.update(__MODULE__, fn map ->
      Map.put(map, key, elem)
    end)

    {key, elem}
  end

  def atualizar_elem(key, elem) do
    Agent.update(__MODULE__, fn map ->
      Map.update!(map, key, elem)
    end)
  end

  def elements do
    ShowMap.show(Agent.get(__MODULE__, & &1))
  end

  def size do
    ShowMap.size(Agent.get(__MODULE__, & &1))
  end

  def kill do
    Process.exit(__MODULE__, :kill)
  end
end
