alias Mix.Shell.IO, as: Shell

defmodule Conditions.CLI do
  def localization() do 
    Shell.prompt("Type the localization that you want search:")
    |> String.trim()
    |> String.upcase()
  end
end
