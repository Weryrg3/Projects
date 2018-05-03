defmodule SequenceStack.Server do
  use GenServer
  @name {:global, __MODULE__}
  # API
  def start_link(elements) do
    GenServer.start_link(__MODULE__, elements, name: @name)
  end

  def next do
    GenServer.call(@name, :next)
  end

  def push(element) do
    GenServer.cast(@name, {:push, element})
  end

  def pop_value(element) do
    GenServer.cast(@name, {:pop_value, element})
  end

  def pop_index(index) do
    GenServer.cast(@name, {:pop_index, index})
  end

  def show do
    GenServer.call(@name, :show)
  end
  # impl

  def init(initial_elements) do
    {:ok, initial_elements}
  end

  def handle_call(:show, _from, list) do
    {:reply, list, list}
  end

  def handle_call(:next, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, element}, list) do
    if element < 10 do
      System.halt(0)
    end
    {:noreply, [element] ++ list}
  end

  def terminate(reason, state) do
    IO.puts("Reason: #{inspect reason}, State: #{inspect state} ")
    state
  end
end

# {:ok, pid} = GenServer.start_link(SequenceStack.Server, [10, 20, 30])
# GenServer.call(pid, :next)
