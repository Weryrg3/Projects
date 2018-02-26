defmodule Test.Xml do
  use ExUnit.Case

  test "Retorno do site" do
    assert {:ok, %HTTPoison.Response{status_code: 200}} = Conditions.Xml.request_xml("KADC")
    assert {:ok, %HTTPoison.Response{status_code: 404}} = Conditions.Xml.request_xml("NY")
  end
end