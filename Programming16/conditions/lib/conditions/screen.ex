defmodule Conditions.Screen do
  def organize({:page_not_found, _body}), do: {:error, "Page not found"}
  def organize({:error, reason}), do: {:error, "Error reason #{reason}"}
  def organize({:ok, body}), do: {:ok, body}

  def structure(old_tuple) do
    tuple = join_data(old_tuple)
    title = "#{elem(tuple, 0)}"
    group1 = max_length(Enum.map(1..4, &elem(tuple, &1)))
    group2 = max_length(Enum.map(5..8, &elem(tuple, &1)))
    group3 = max_length(Enum.map(9..12, &elem(tuple, &1)))

    traces = &String.duplicate("-", String.length(&1) + 4)

    "\n#{traces.(title)}\n#{trace_v(title)}\n#{traces.(title)}\n#{traces.(group1)}\n#{
      trace_v(elem(tuple, 1), group1)}\n#{
      trace_v(elem(tuple, 2), group1)}\n#{
      trace_v(elem(tuple, 3), group1)}\n#{
      trace_v(elem(tuple, 4), group1)}\n#{traces.(group1)}\n#{
      traces.(group2)}  #{traces.(group3)}\n#{
      trace_v(elem(tuple, 5), group2)}  #{
      trace_v(elem(tuple, 9), group3)}\n#{
      trace_v(elem(tuple, 6), group2)}  #{
      trace_v(elem(tuple, 10), group3)}\n#{
      trace_v(elem(tuple, 7), group2)}  #{
      trace_v(elem(tuple, 11), group3)}\n#{
      trace_v(elem(tuple, 8), group2)}  #{
      trace_v(elem(tuple, 12), group3)}\n#{traces.(group2)}  #{
      traces.(group3)
    }\n"
  end

  defp trace_v(main_string, big_string \\ "") do
    size = 
      [main_string, big_string]
      |> Enum.map(& String.length(&1))
      |> Enum.min_max()
      |> 
    
    #size = String.length(max) - String.length(min) + 1
    "| #{main_string}#{String.duplicate(" ", size)}|"
  end

  defp max_length(range_list), do: Enum.max_by(range_list, &String.length/1)

  defp join_data(tuple) do
    pad = &"#{String.duplicate(" ", &2)} #{&1}"
    # require IEx
    # IEx.pry
    {
      elem(tuple, 0),
      elem(tuple, 1),
      "(#{elem(tuple, 2)}) #{elem(tuple, 3)}N #{elem(tuple, 4)}W",
      elem(tuple, 5),
      "#{pad.(elem(tuple, 6), 15)}",
      "Weather: #{elem(tuple, 7)}",
      "Temperature: #{elem(tuple, 8)}",
      "Dewpoint: #{elem(tuple, 11)}",
      "Relative Humidity: #{elem(tuple, 9)} %",
      "Wind: #{elem(tuple, 10)}",
      "Visibility: #{elem(tuple, 12)} miles",
      "Altimeter: #{elem(tuple, 13)} in Hg",
      "http://w1.weather.gov"
    }
  end
end