defmodule DungeonCrawl.Room.Triggers.Safe do
  @behaviour DungeonCrawl.Room.Trigger
  alias Mix.Shell.IO, as: Shell
  # alias DungeonCrawl.Life
  alias DungeonCrawl.Character

  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    {character, :forward}
  end

  def run(character, %DungeonCrawl.Room.Action{id: :rest}) do
    vida = Enum.random(1..(div(character.max_hit_points, 2)))
     
    Shell.info("Você descansou bem e recebeu #{vida} de vida.")
    
    {Character.heal(character, vida, 1), :forward}
    #{Life.rest(character, vida), :forward}
  end
end
