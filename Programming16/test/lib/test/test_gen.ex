defmodule Test.TestGen do
  use GenServer

  def start_link(number) do
    GenServer.start_link(__MODULE__, number, name: __MODULE__)
  end

  def init(number) do
    {:ok, number}
  end

  def show do
    GenServer.call(__MODULE__, :show)
  end

  def handle_call(:show, _from, numbers) do
    {:reply, numbers, numbers}
  end

  def handle_cast({:new_number, number}, numbers) do
    {:noreply,numbers + number}
  end
end
