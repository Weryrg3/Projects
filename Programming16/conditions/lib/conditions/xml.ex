defmodule Conditions.Xml do
  @moduledoc "Arquivo de tratamento de XML, request o site 
  e pega todas as chaves que serão usadas."
  require Record


  Record.defrecord(
    :xmlAttribute,
    Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")
  )

  Record.defrecord(:xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl"))

  def request_xml(loc) do
    # base_url = Application.get_env(:conditions, :w1_weather)           # -> It's not working
    # HTTPoison.get("#{base_url}/xml/current_obs/#{loc}.xml")            # -> It's not working
    HTTPoison.get("http://w1.weather.gov/xml/current_obs/#{loc}.xml")
  end

  def word_for_search do
    [
      "//title",
      "//location",
      "//station_id",
      "//latitude",
      "//longitude",
      "//observation_time",
      "//observation_time_rfc822",
      "//weather",
      "//temperature_string",
      "//relative_humidity",
      "//wind_string",
      "//dewpoint_string",
      "//visibility_mi",
      "//pressure_in"
    ]
  end

  def xml_for_list(xml) do
    words = word_for_search()
    node = from_string(xml)

    words
    |> Enum.map(&first(node, &1))
    |> Enum.map(&text(&1))
    |> List.to_tuple()
  end

  def from_string(xml_string, options \\ [quiet: true]) do
    {doc, []} =
      xml_string
      |> :binary.bin_to_list()
      |> :xmerl_scan.string(options)

    doc
  end

  def all(node, path) do
    for child_element <- xpath(node, path) do
      child_element
    end
  end

  def first(node, path), do: node |> xpath(path) |> take_one
  defp take_one([head | _]), do: head
  defp take_one(_), do: nil

  def node_name(nil), do: nil
  def node_name(node), do: elem(node, 1)

  def attr(node, name), do: node |> xpath('./@#{name}') |> extract_attr
  defp extract_attr([xmlAttribute(value: value)]), do: List.to_string(value)
  defp extract_attr(_), do: nil

  def text(node), do: node |> xpath('./text()') |> extract_text
  defp extract_text([xmlText(value: value)]), do: List.to_string(value)
  defp extract_text(_x), do: nil

  defp xpath(nil, _), do: []

  defp xpath(node, path) do
    :xmerl_xpath.string(to_charlist(path), node)
  end
end

# doc =
# Conditions.Xml.from_string("""
# <root>
# <child id="1">Saša</child>
# <child id="2">Jurić</child>
# </root>
# """)
# 
# Enum.each(Conditions.Xml.all(doc, "//child"), fn node ->
# IO.puts(
# "#{Conditions.Xml.node_name(node)} id=#{Conditions.Xml.attr(node, "id")} text=#{
# Conditions.Xml.text(node)
# }"
# )
# end)
# 
# IO.puts(
# doc
# |> Conditions.Xml.first("//child[@id='2']")
# |> Conditions.Xml.text()
# )
# 
# IO.puts(
# doc
# |> Conditions.Xml.first("//child[@id='3']")
# |> Conditions.Xml.text()
# )
# 
# IO.puts(
# doc
# |> Conditions.Xml.first("//root")
# |> Conditions.Xml.first("child[@id='1']")
# |> Conditions.Xml.text()
# )
