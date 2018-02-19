defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room
  alias DungeonCrawl.Room.Triggers

  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: [], trigger: nil

  def all(n) do
    
    if n > 0 do
      [
        %Room{
          description: "Você pode ver um inimigo bloqueando seu caminho.", # "You can see an enemy blocking your path.",
          # actions: [forward()],
          actions: [forward()], 
          trigger: Triggers.Enemy
        },
        %Room{
          # description: "You found a quiet place. Looks safe for a little nap.",
          description: "Você encontrou um lugar calmo. Parece seguro para uma pequena soneca.",
          actions: [forward(), rest()],
          trigger: Triggers.Safe
        }
      ]
    else
      [
        %Room{
          description: "Você pode ver a luz do dia. Você encontrou a saída!", # "You can see the light of the day. You found the exit!",
          # actions: [forward()],
          actions: [forward()], 
          trigger: Triggers.Exit
        },
        %Room{
          description: "Você pode ver um inimigo bloqueando seu caminho.", # "You can see an enemy blocking your path.",
          # actions: [forward()],
          actions: [forward()], # tentativa de alteração 1, faltante code ############################################
          trigger: Triggers.Enemy
        },
        %Room{
          # description: "You found a quiet place. Looks safe for a little nap.",
          description: "Você encontrou um lugar calmo. Parece seguro para uma pequena soneca.",
          actions: [forward(), rest()],
          trigger: Triggers.Safe
        },
        %Room{
          description: "Você encontrou um lugar diferente. Talvez possa ter recursos ou poções.",
          actions: [forward(), search()],
          trigger: Triggers.Different
        }
      ]
    end
  end  
end
