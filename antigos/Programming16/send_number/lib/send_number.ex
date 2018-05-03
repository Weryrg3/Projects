defmodule SendNumber do
  alias SendNumber.Clients.SendNumbers

  def start(num \\ 3) do
    SendNumbers.start_link(num)
  end
end

