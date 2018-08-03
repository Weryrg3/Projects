defmodule Learn.Buttons2Channel do
  use Learn.Web, :channel
  @moduledoc """
  Channel buttons2, atualização de bootstrap.
  """
  def join("buttons2:" <> _buttons, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_click", params, socket) do
    broadcast!(socket, "new_click", %{
      div_str_button: params["div_button"],
      div_str_menu: params["div_menu"],
    })

    {:reply, :ok, socket}
  end
end
