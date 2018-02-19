defmodule DungeonCrawl.Objects do
  alias DungeonCrawl.Character

  def all,
    do: [
      %Character{
        name: "força", 
        description: "uma Pequena poção mágica de força.", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 2..2,
        attack_description: "aumenta a força de ataque.",
        score: 2
      },
      %Character{
        name: "Nada", 
        description: "Nada", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 0
      },
      %Character{
        name: "força", 
        description: "uma Poção magica média de força.", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 4..4,
        attack_description: "aumenta a força de ataque.",
        score: 4
      },
      %Character{
        name: "Nada", 
        description: "Nada", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 0
      },
      %Character{
        name: "vida", 
        description: "uma pequena poção de cura.", 
        hit_points: 2,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 4
      },
      %Character{
        name: "Nada", 
        description: "Nada", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 0
      },
      %Character{
        name: "vida", 
        description: "uma poção média de cura.", 
        hit_points: 4,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 8
      },
      %Character{
        name: "Nada", 
        description: "Nada", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 0
      },
      %Character{
        name: "Nada", 
        description: "Nada", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 0
      }
    ]
end