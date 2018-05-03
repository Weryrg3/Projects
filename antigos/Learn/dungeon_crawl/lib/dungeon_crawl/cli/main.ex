defmodule DungeonCrawl.CLI.Main do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.DifficultChoice
  import DungeonCrawl.ScoreSystem
  
  def start_game do
    welcome_message()
    # Shell.prompt("Press enter to continue")
    Shell.prompt("Pressione enter para continuar")
    #crawl(hero_choice(), DungeonCrawl.Room.start_rooms()) no works!!! 
    crawl(hero_choice(), DungeonCrawl.Room.all(nil))    # -> Inicio Valor inicial desconsiderado
    # crawl(hero_choice(), DungeonCrawl.Room.all(5))
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end

  defp difficult do
    Shell.info("Selecione a dificuldade")
    start_difficult()
  end

  defp welcome_message do
    Shell.info("== Dungeon Crawl ===")
    # Shell.info("You awake in a dungeon full of monsters.")
    # Shell.info("You need to survive and find the exit.")
    Shell.info("Você acorda em uma masmorra cheia de monstros.")
    Shell.info("Você precisa sobreviver e encontrar a saída.")
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end

  defp hero_choice do
    hero = DungeonCrawl.CLI.HeroChoice.start() 
    #%{hero | name: "You"}
    {difficult, difficult_selected} = difficult()

    %{hero | name: "Você", difficult: difficult, difficult_selected: difficult_selected}
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end

  defp crawl(%{hit_points: 0}, _) do
    Shell.prompt("")
    # Shell.cmd("clear")  # Não funciona
    # Shell.info("Unfortunately your wounds are too many to keep walking.")
    # Shell.info("You fall onto the floor without strength to carry on.")
    Shell.info("Infelizmente, suas feridas são demais para continuar andando.")
    Shell.info("Você cai no chão sem forças para continuar.")
    Shell.info("Game over!")
    Shell.prompt("")
    # require IEx; IEx.pry
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end

  defp crawl(character, rooms) do
    # Shell.info("You keep moving forward to the next room.")
    # Shell.prompt("Press enter to continue")
    Shell.info("Você continua avançando para a próxima sala.")
    Shell.prompt("Pressione enter para continuar")
    # Shell.cmd("clear")  # Não funciona
                                  
    Shell.info(DungeonCrawl.Character.current_stats(character))                   
                                                                              
    rooms ####################################################################################
    |> Enum.random
    |> DungeonCrawl.CLI.RoomActionsChoice.start
    |> trigger_action(character)
    |> handle_action_result
  end

  defp trigger_action({room, action}, character) do
    # Shell.cmd("clear")  # Não funciona
    room.trigger.run(character, action)   # Variável room acessando o struct trigger que está retornando uma função dessa função acessando run
    # Selo de entendimento de Module  ->  75%   ->  ---------------------------------------------------------------------------#########################|
  end

  defp handle_action_result({character, :exit}) do
     Shell.info("Você encontrou a saída. Você ganhou o jogo. Parabéns!") #Shell.info("You found the exit. You won the game. Congratulations!")
     Shell.info("")
     Shell.prompt("Pressione enter")
     score(character)
  end
    
  defp handle_action_result({character, _}) do
    difficult = character.difficult - 1
    # score = character.score + 1
    crawl(%{character | difficult: difficult}, DungeonCrawl.Room.all(difficult))  #############################################################################################
  end
end


# • Faça assim que o herói possa armazenar itens no bolso para usar mais tarde. Para
# Por exemplo, eles podem pegar a poção de cura no tesouro e
# use-o mais tarde, quando perderam pontos de vida. Adicione uma opção para usar o item
# ao listar as ações da sala. É bom indicar o número máximo de
# itens que o herói pode acumular.

# • Melhorar o módulo de batalha, dando ao jogador a opção de fugir ou
# ataque naquela rodada. Quando o herói estiver fugindo, o herói receberá um
# ataque do inimigo antes de fugir


# cli programas que rodam na linha de comando.