defmodule DungeonCrawl.Room.Triggers.Enemy do
  @behaviour DungeonCrawl.Room.Trigger

  alias Mix.Shell.IO, as: Shell

  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    enemy = Enum.random(DungeonCrawl.Enemies.all())

    Shell.info(enemy.description)
    # Shell.info("The enemy #{enemy.name} wants to fight.")
    Shell.info("O inimigo #{enemy.name} quer lutar.")
    # Shell.info("You were prepared and attack first.")
    Shell.info("Você estava preparado e atacou primeiro.")
    {updated_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy)

    {updated_char, :forward}
  end
end
