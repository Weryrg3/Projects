defmodule DungeonCrawl.ScoreSystem do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def score(character) do
    if File.exists?("score_system.txt") do
      {:ok, file} = File.read("score_system.txt")
      name = String.trim(Shell.prompt("Digite seu nome:"))
      score = character.score

      scores = String.split(file, "\n")
      # scores = ["Name: #{name}, Score: #{score}"] ++ scores

      new_scores =
        case file do
          "" ->
            ["Name: #{name}, Score: #{score}"]
          _ ->
            scores = ["Name: #{name}, Score: #{score}"] ++ scores
            scores
            |> Enum.sort_by(
              # fn a, b -> a >= b end
              &(&1
                |> String.split("Score: ")
                |> Enum.at(1)
                |> String.to_integer()),
              &>=/2
            )
        end

      Shell.info("Top 10 Scores:")

      take_new_scores =
        new_scores
        |> Enum.take(10)
        |> Enum.join("\n")

        # require IEx; IEx.pry
      
      display_options(String.split(take_new_scores, "\n"))
      # Enum.join(Enum.take(new_scores, 10), "\n")

      File.write!("score_system.txt", take_new_scores)
    else
      Shell.cmd("touch score_system.txt")
      score(character)
    end
  end
end