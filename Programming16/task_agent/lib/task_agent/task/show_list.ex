defmodule TaskAgent.Task.ShowList do
  use Task
  alias TaskAgent.Agent.List

  def start_link(list) do
    Task.start_link(__MODULE__, :init_agent, [list])
  end

  def init_agent(list) do
    List.start(list)
  end

  def show(list) do
    Enum.each(list, &IO.puts/1)
    list
  end

  def size(list) do
    IO.puts(length(list))
    length(list)
  end

  def kill do
    Process.exit(self(), :kill)
  end
end
