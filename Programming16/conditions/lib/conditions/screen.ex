defmodule Conditions.Screen do
  
  
  def organize({:page_not_found, _body}), do: {:error, "Page not found"}
  def organize({:error, reason}), do: {:error, "Error reason #{reason}"}

  def organize({:ok, body}) do
    # -> Verificar depois, a atribuição parece acabar com Timeout do HTTPoison?? Why??
    test_body = body

    {:ok, test_body}
  end

  def structure(old_tuple) do
    tuple = join_data(old_tuple)
    title = "#{elem(tuple, 0)}"
    site = "http://w1.weather.gov"
    group1 = max_length({elem(tuple, 1), elem(tuple, 2), elem(tuple, 3), elem(tuple, 4)})
    group2 = max_length({elem(tuple, 5), elem(tuple, 6), elem(tuple, 7), elem(tuple, 8)})
    group3 = max_length({elem(tuple, 9), elem(tuple, 10), elem(tuple, 11), site})
    traces = &String.duplicate("-", String.length(&1) + 4)
        
    "\n#{traces.(title)}\n#{trace_v(title, "")}\n#{traces.(title)}\n#{traces.(group1)}\n#{
      trace_v(elem(tuple, 1), group1)}\n#{
      trace_v(elem(tuple, 2), group1)}\n#{
      trace_v(elem(tuple, 3), group1)}\n#{
      trace_v(group1)}\n#{traces.(group1)}\n#{traces.(group2)}  #{traces.(group3)}\n#{
      trace_v(elem(tuple, 5), group2)}  #{trace_v(elem(tuple, 9), group3)}\n#{
      trace_v(group2)}  #{trace_v(elem(tuple, 10), group3)}\n#{
      trace_v(elem(tuple, 7), group2)}  #{trace_v(elem(tuple, 11), group3)}\n#{
      trace_v(elem(tuple, 8), group2)}  #{trace_v(site, group3)}\n#{traces.(group2)}  #{traces.(group3)}\n"
  end

  def trace_v(main_string, big_string \\ "") do  
    if big_string == "" do
      "| #{main_string}#{String.duplicate(" ", 1)}|"
    else
      size = String.length(big_string) - String.length(main_string) + 1
      "| #{main_string}#{String.duplicate(" ", size)}|"
    end
  end

  def max_length(range_tuple) do
    range_tuple
      |> Tuple.to_list()
      |> Enum.max_by(&String.length/1)
  end

  def join_data(tuple) do
    pad = &"#{String.duplicate(" ", &2)} #{&1}"
    # require IEx
    # IEx.pry
    {elem(tuple, 0), elem(tuple, 1), "(#{elem(tuple, 2)}) #{elem(tuple, 3)}N #{elem(tuple, 4)}W",
    elem(tuple, 5), "#{pad.(elem(tuple, 6), 15)}", "Weather: #{elem(tuple, 7)}", "Temperature: #{elem(tuple, 8)}", "Dewpoint: #{elem(tuple, 11)}", 
    "Relative Humidity: #{elem(tuple, 9)} %", "Wind: #{elem(tuple, 10)}", "Visibility: #{elem(tuple, 12)} miles", "Altimeter: #{elem(tuple, 13)} in Hg"}
  end
end


# -----------------------------------
# | NOAA's National Weather Service |
# -----------------------------------
# 
# ---------------------------------------------
# | Anchorage, Merrill Field Airport, AK      |
# | (PAMR) 61.2167N -149.85W                  |
# | Last Updated on Feb 27 2018, 5:53 am AKST |
# | Tue, 27 Feb 2018 05:53:00 -0900           |
# ---------------------------------------------
# 
# Weather: Overcast
# Temperature: 11.0 F (-11.7 C)
# Dewpoint: 8.1 F (-13.3 C)
# Relative Humidity: 88 %

# Wind: Calm
# Visibility: 10.00
# Altimeter: 29.55





