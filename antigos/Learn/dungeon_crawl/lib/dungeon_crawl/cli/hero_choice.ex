defmodule DungeonCrawl.CLI.HeroChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands  # Ordem de precendência ou seja esse deve ser compilado primeiro

  def start do
    # Shell.cmd("clear")  # Não funciona
    #Shell.info("Start by choosing your hero:")
    Shell.info("Comece escolhendo seu herói:")
    
    DungeonCrawl.Heroes.all()
    |> ask_for_option()
    |> confirm_hero             # OK (100%)
    
  end

  defp confirm_hero(chosen_hero) do
    # Shell.cmd("clear")  # Não funciona
    Shell.info(chosen_hero.description)
    if Shell.yes?("Confirm?"), do: chosen_hero, else: start()
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end
end
