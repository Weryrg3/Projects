defmodule Mix.Tasks.Start do
  use Mix.Task
  def run(_), do: ImpureFunctions.CLI.start()
end
