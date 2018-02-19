defmodule DungeonCrawl.CLI.RoomActionsChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start(room) do
    room_actions = room.actions
    find_action_by_index = &Enum.at(room_actions, &1)

    Shell.info(room.description())        ################################################## perguntar depois

    chosen_action =
      room_actions                # OK (100%)
      |> display_options          # OK (100%)
      |> generate_question        # OK (100%)
      |> Shell.prompt()           # OK (100%)
      |> parse_answer             # OK (100%)
      |> find_action_by_index.()  # OK (100%)

    {room, chosen_action}
  end
  # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
end