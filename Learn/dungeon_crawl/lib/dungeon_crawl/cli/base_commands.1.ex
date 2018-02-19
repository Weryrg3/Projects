defmodule DungeonCrawl.CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  def display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)
    # Selo de entendimento de Module  ->  75%   ->  ---------------------------------------------------------------------------#########################|
    options
  end

  def generate_question(options) do
    options = Enum.join(1..Enum.count(options),",")
    "Qual? [#{options}]\n"  # "Which one? [#{options}]\n"
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end

  def parse_answer(answer) do
    {option, _} = Integer.parse(answer)
    option - 1
    # Selo de entendimento de Module  ->  100%  ->  ----------------------------------------------------------------------------------------------------|
  end
end