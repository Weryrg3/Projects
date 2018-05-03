defmodule TaskAgent.Task.ShowList do
  use Task
  alias TaskAgent.Agent.List
  alias TaskAgent.Task.ShowList

  def start_link(list) do
    Task.start_link(__MODULE__, :init_agent, [list])
  end

  def init_agent(list) do
    List.start(list)
  end

  def show(list) do
    Enum.each(list, &IO.inspect/1)
    list
  end

  def size(list) do
    IO.puts(length(list))
    length(list)
  end

  def kill do
    ShowList.kill_me()
  end

  def kill_me do
    Process.exit(self(), :kill)
  end
end
