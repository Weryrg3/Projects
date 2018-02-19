defmodule DungeonCrawl.Life do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.Character

  def searching(character, object) do
    if object.name == "Nada" do
      Shell.info("Você não encontrou nenhum objeto mágico.")
      character
    else
      Shell.info("Vocẽ encontrou #{object.description}")
      Shell.info("HP: #{character.hit_points}/#{character.max_hit_points}")
      Shell.info("Sua #{object.name} aumentou.")

      if object.name == "Vida" do
        heal(character, object.hit_points, object.score)
        # rest(character, object.hit_points)
        Shell.info("HP: #{character.hit_points}/#{character.max_hit_points}")
      else
        first_o..last_o = object.damage_range
        first_c..last_c = character.damage_range
        new_damage_range = (first_o + first_c)..(last_o + last_c)
        new_score = object.score + last_o
        %{character | damage_range: new_damage_range, score: new_score}
      end
    end
  end
end
