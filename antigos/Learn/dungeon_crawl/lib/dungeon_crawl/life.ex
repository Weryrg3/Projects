defmodule DungeonCrawl.Life do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.Character

  def searching(character, object) do
    if object.name == "Nada" do
      Shell.info("Você não encontrou nenhum objeto mágico.")
      character
    else
      if object.name == "trap" do
        Shell.info("Você caiu numa armadilha e perdeu #{object.hit_points} de vida.")
        character = take_damage(character, object.hit_points, object.score)
        Shell.info("HP: #{character.hit_points}/#{character.max_hit_points}")
        character
      else
        Shell.info("Vocẽ encontrou #{object.description}")
        Shell.info("Sua #{object.name} aumentou.")
        Shell.info("HP: #{character.hit_points}/#{character.max_hit_points}")

        case object.name do
          "vida" ->
            character = heal(character, object.hit_points, object.score)
            Shell.info("HP: #{character.hit_points}/#{character.max_hit_points}")
            character

          "força" ->
            first_o..last_o = object.damage_range
            first_c..last_c = character.damage_range
            new_damage_range = (first_o + first_c)..(last_o + last_c)
            new_score = object.score + last_o
            %{character | damage_range: new_damage_range, score: new_score}
        end
      end
    end
  end
end