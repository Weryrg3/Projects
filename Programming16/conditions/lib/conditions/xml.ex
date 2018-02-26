defmodule Conditions.Xml do
  def request_xml(loc) do
    HTTPoison.get("http://w1.weather.gov/xml/current_obs/#{loc}.xml")   
  end
end