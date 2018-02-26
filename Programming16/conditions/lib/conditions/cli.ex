alias Mix.Shell.IO, as: Shell

defmodule Conditions.CLI do
  def localization() do 
    Shell.info("Type State, City or name of the aiport of US")
    Shell.prompt("Type the localization that you want search:")
    |> String.trim()
    |> String.upcase()
  end

  def search_database(search) do
    
  end
end