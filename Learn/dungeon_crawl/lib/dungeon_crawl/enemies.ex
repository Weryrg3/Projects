defmodule DungeonCrawl.Enemies do
  alias DungeonCrawl.Character

  def all,
    do: [
      %Character{
        name: "Ogro", # "Ogre",
        description: "Uma criatura alta e grande. Grandes músculos. Irritado e com fome.", #"A tall and large creature. Big muscles. Angry and hungry.",
        hit_points: 12,
        max_hit_points: 12,
        damage_range: 3..5,
        attack_description: "um martelo" # "a hammer"
      },
      %Character{
        name: "Orc",
        description: "Uma criatura do mal verde. Veste uma armadura e um machado.", #"A green evil creature. Wears an armor and an axe.",
        hit_points: 8,
        max_hit_points: 8,
        damage_range: 2..4,
        attack_description: "um machado" # "an axe"
      },
      %Character{
        name: "Goblin",
        description: "Uma pequena e fina criatura verde doente. Veste roupas sujas 
        e uma adaga.", #"A small and thin evil green creature. Wears dirty clothes and a dagger.",
        hit_points: 4,
        max_hit_points: 4,
        damage_range: 1..2,
        attack_description: "uma adaga" # "a dagger"
      }
    ]
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
end