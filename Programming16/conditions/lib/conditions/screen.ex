defmodule Conditions.Screen do
  
  def organize({:error, reason}) do
    "Error reason #{reason}"
  end

  def organize({:ok, body}) do
    body 
      # |> String.split("<location")
      # |> List.to_tuple()
  end

  # def show(tuple) do
    # 
  # end
end

# <location>
# <station
# <latitude>
# <longitude> 
# observation time
# observation time rfc822
# ...