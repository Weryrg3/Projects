defmodule Mix.Tasks.Start do
  @moduledoc "Inicia a aplicação por fora no iex -S mix"
  use Mix.Task

  def run(_) do
    Application.ensure_all_started(:conditions)
    Conditions.Main.start()
  end
end
