defmodule DungeonCrawl.Heroes do
  alias DungeonCrawl.Character

  def all,
    do: [
      %Character{
        name: "Cavaleiro", # "Knight",
        description: "Cavaleiro tem defesa forte e dano consistente.", #"Knight has strong defense and consistent damage.",
        hit_points: 18,
        max_hit_points: 18,
        damage_range: 4..5,
        attack_description: "uma espada" # "a sword"
      },
      %Character{
        name: "Bruxo", # "Wizard",
        description: "Bruxo tem forte ataque, mas baixa saúde.", # "Wizard has strong attack, but low health.",
        hit_points: 8,
        max_hit_points: 8,
        damage_range: 6..10,
        attack_description: "uma bola de fogo" # "a fireball"
      },
      %Character{
        name: "Vampiro", # "Rogue",
        description: "Vampiro tem alta variabilidade de ataque de dano.", # "Rogue has high variability of attack damage.",
        hit_points: 12,
        max_hit_points: 12,
        damage_range: 1..12,
        attack_description: "uma adaga" # "a dagger" 
      }
    ]
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
end