defmodule TaskAgent.Agent.List do
  alias TaskAgent.Task.ShowList
  alias TaskAgent.Agent.List, as: ListAgent

  def start(param) do
    Agent.start_link(fn -> param end, name: __MODULE__)
  end

  def add_elem_begin(elem) do
    Agent.update(__MODULE__, fn list ->
      [elem | list]
    end)
  end

  def add_elem_final(elem) do
    Agent.update(__MODULE__, fn list ->
      list ++ [elem]
    end)
  end

  def size do
    ShowList.size(Agent.get(__MODULE__, & &1))
  end

  def elements do
    ShowList.show(Agent.get(__MODULE__, & &1))
  end

  def kill do
    ListAgent.kill_me()
  end

  def kill_me do
    Process.exit(__MODULE__, :kill)
  end
end
