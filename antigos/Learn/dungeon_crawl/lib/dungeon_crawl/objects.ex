defmodule DungeonCrawl.Objects do
  alias DungeonCrawl.Character

  def all,
    do: [
      %Character{
        name: "trap", 
        description: "armadilha", 
        hit_points: 5,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 10
      },
      %Character{
        name: "força", 
        description: "uma Pequena poção mágica de força.", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 2..2,
        attack_description: "aumenta a força de ataque.",
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
        name: "força", 
        description: "uma Poção magica média de força.", 
        hit_points: 0,
        max_hit_points: 0,
        damage_range: 3..3,
        attack_description: "aumenta a força de ataque.",
        score: 9
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
        name: "vida", 
        description: "uma poção média de cura.", 
        hit_points: 4,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 16
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
      },
      %Character{
        name: "trap", 
        description: "armadilha", 
        hit_points: 10,
        max_hit_points: 0,
        damage_range: 0..0,
        attack_description: "",
        score: 20
      }
    ]
end