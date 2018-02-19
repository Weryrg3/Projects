defmodule DungeonCrawl.CLI.DifficultChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands
  def start_difficult() do
    difficults = ["Fácil", "Médio", "Difícil"]
    find_action_by_index = &Enum.at(difficults, &1)

    chosen_difficult =
      difficults                  # OK (100%)
      |> display_options          # OK (100%)
      |> generate_question        # OK (100%)
      |> Shell.prompt()           # OK (100%)
      |> parse_answer             # OK (100%)
      |> find_action_by_index.()  # OK (100%)

    difficult = case chosen_difficult do
      "Fácil" ->  5
      "Médio" ->  10
      "Difícil" ->  15
    end
      {difficult, chosen_difficult}
  end
end