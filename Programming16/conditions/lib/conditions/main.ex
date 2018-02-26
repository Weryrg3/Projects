# alias Mix.Shell.IO, as: Shell
import Conditions.CLI
import Conditions.Xml
import Conditions.Screen

defmodule Conditions.Main do
  def start() do
    localization()
      |> request_xml()
      |> xml_response()
      |> organize()
      # |> show()
  end

  defp xml_response({:ok, %{status_code: status_code, body: body}}) do
    new_status = case status_code do
      200 -> :ok
      404 -> :page_not_found
      _ -> :error
    end

    {new_status, body}
  end

  defp xml_response({:page_not_found, _body}), do: {:error, "Page not found"}
  defp xml_response({:error, %{reason: :timeout}}), do: {:error, "timeout"}
end