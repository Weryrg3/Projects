defmodule Novo.Workers do
  use GenServer
  @me __MODULE__
  def start_link(number_process) do
    GenServer.start_link(@me, number_process, name: @me)
  end

  def init(number_process) do
    {:ok, number_process}
  end
end
