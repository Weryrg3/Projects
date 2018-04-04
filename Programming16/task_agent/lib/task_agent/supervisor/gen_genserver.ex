defmodule TaskAgent.Supervisor.GenGenServer do
  use GenServer

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(arg) do
    {:ok, arg}
  end

  def new_number(number) do
    GenServer.call(__MODULE__, {:new_number, number})
  end

  def show do
    GenServer.call(__MODULE__, :show)
  end

  def kill do
    Process.exit(self(), :kill)
  end

  def handle_call({:new_number, number}, _from, state) do
    {:reply, number, state + number}
  end

  def handle_call(:show, _from, state) do
    {:reply, state, state}
  end
end
