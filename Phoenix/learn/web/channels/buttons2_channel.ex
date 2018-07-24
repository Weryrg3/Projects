defmodule Learn.Buttons2Channel do
  use Learn.Web, :channel

  def join("buttons2:" <> _buttons, _params, socket) do
    :timer.send_interval(5_000, :ping)
    {:ok, socket}
  end

  def handle_info(:ping, socket) do
    count = socket.assigns[:count] || 1
    push(socket, "ping", %{count: count})
    {:noreply, assign(socket, :count, count + 1)}
  end
end
