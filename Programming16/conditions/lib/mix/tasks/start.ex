defmodule Mix.Tasks.Start do
  use Mix.Task

  def run(_) do
    Application.ensure_all_started(:conditions)
    Conditions.Main.start()
  end
end