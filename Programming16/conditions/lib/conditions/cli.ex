alias Mix.Shell.IO, as: Shell

defmodule Conditions.CLI do
  def localization() do
    Shell.info("Choice the option:")
    Shell.info("1 - Type the localization of airport that you want search:")
    Shell.info("2 - Random aiport of US 1 into 382")

    Shell.prompt("Your choice is:")
    |> String.trim()
    |> case do
      "1" ->
        Shell.prompt("Type the localization of airport that you want search:")
        |> String.trim()
        |> String.upcase()

      "2" ->
        Shell.info("Choosing a random airport")
        read_database()

      _ ->
        Shell.info("Choice wrong, retype!!!")
        localization()
    end
  end

  def read_database() do
    data =
      File.read!("database.txt")
      |> String.split()

    number_random = Enum.random(1..Enum.count(data))

    data
    |> List.to_tuple()
    |> elem(number_random - 1)
  end
end