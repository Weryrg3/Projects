# alias Mix.Shell.IO, as: Shell
import Conditions.CLI
import Conditions.Xml

defmodule Conditions.Main do
  def start() do
    localization()
      |> request_xml()
      |> xml_response()
  end

  defp xml_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error(),
      body
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end