defmodule DungeonCrawl.CLI.DifficultChoice do
  # alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands
  def start_difficult() do
    difficults = ["Fácil", "Médio", "Difícil"]

    chosen_difficult =
      difficults                  # OK (100%)
      |> ask_for_option()

    difficult = case chosen_difficult do
      "Fácil" ->  5
      "Médio" ->  10
      "Difícil" ->  15
    end
      {difficult, chosen_difficult}
  end
end