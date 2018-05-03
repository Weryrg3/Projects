defmodule TaskAgent.SimpleProg.SimpleTaskAgent do
  def agent_start_link do
    Agent.start_link(fn -> [] end, name: :sa)
  end

  def agent_add_value(value) do
    Agent.update(:sa, fn list ->
      [value | list]
    end)
  end

  def agent_show do
    Agent.get(:sa, fn list -> list end)
  end

  def task_start_link do
    Task.start_link(fn -> [] end)
  end
end
