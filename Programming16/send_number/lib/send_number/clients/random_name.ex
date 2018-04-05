defmodule SendNumber.Clients.RandomName do
  def names do
    File.read!("names")
    |> String.split()
    |> Enum.random()
  end
end
