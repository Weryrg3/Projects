defmodule DungeonCrawl.CLI.HeroChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands  # Ordem de precendência ou seja esse deve ser compilado primeiro

  def start do
    # Shell.cmd("clear")  # Não funciona
    #Shell.info("Start by choosing your hero:")
    Shell.info("Comece escolhendo seu herói:")
    heroes = DungeonCrawl.Heroes.all()
    find_hero_by_index = &Enum.at(heroes, &1)

    heroes
    |> display_options          # OK (50%)
    |> generate_question        # OK (100%)
    |> Shell.prompt()           # OK (100%)
    |> parse_answer             # OK (100%)
    |> find_hero_by_index.()    # OK (100%)
    |> confirm_hero             # OK (100%)
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end

  defp confirm_hero(chosen_hero) do
    # Shell.cmd("clear")  # Não funciona
    Shell.info(chosen_hero.description)
    if Shell.yes?("Confirm?"), do: chosen_hero, else: start()
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end
end
