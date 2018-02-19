defmodule DungeonCrawl.Character do
  defstruct name: nil,
            description: nil,
            hit_points: 0,
            max_hit_points: 0,
            attack_description: nil,
            damage_range: nil,
            difficult: 0,
            score: 0,
            handbag: []

  @type t :: %DungeonCrawl.Character{ # Estudar mais sobre @type
    name: String.t,
    description: String.t,
    hit_points: non_neg_integer,
    max_hit_points: non_neg_integer,
    attack_description: String.t,
    damage_range: Range.t,
    difficult: non_neg_integer,
    score: non_neg_integer
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  }

  def take_damage(character, damage) do
    new_hit_points = max(0, character.hit_points - damage)
    new_score = character.score + new_hit_points
    %{character | hit_points: new_hit_points, score: new_score}
  end

  def heal(character, healing_value, score) do
    new_hit_points = min(
      character.hit_points + healing_value,
      character.max_hit_points
    )
    new_score = character.score + score
    %{character | hit_points: new_hit_points, score: new_score}
  end

  def current_stats(character),
    do: "Player Stats\nHP: #{character.hit_points}/#{character.max_hit_points}"
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|

  defimpl String.Chars do
    def to_string(character), do: character.name
    # Selo de entendimento de Module  ->  50%   ->  --------------------------------------------------##################################################|
    # Quando ocorre uma interpolação o Protocol String.Chars é chamado passando para o módulo (...).Character chamando então a implementação e devolvendo nomes.
  end
end