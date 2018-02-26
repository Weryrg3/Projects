defmodule Conditions.Xml do
  
  def request_xml(loc) do
    # base_url = Application.get_env(:conditions, :w1_weather)           # -> It's not working
    # HTTPoison.get("#{base_url}/xml/current_obs/#{loc}.xml")            # -> It's not working
    HTTPoison.get("http://w1.weather.gov/xml/current_obs/#{loc}.xml")
  end
end