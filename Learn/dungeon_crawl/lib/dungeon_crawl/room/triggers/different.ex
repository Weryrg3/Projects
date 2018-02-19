defmodule DungeonCrawl.Room.Triggers.Different do
  @behaviour DungeonCrawl.Room.Trigger
  # alias Mix.Shell.IO, as: Shell
  alias DungeonCrawl.Life
  
  
  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    {character, :forward}
  end

  def run(character, %DungeonCrawl.Room.Action{id: :search}) do
    object = Enum.random(DungeonCrawl.Objects.all())
    
    # {Character.heal(character, vida), :forward}
    {Life.searching(character, object), :forward}
  end
end