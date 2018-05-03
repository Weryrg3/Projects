defmodule Stack.Server do
  use GenServer
  @name {:global, __MODULE__}
  # API
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def pop, do: GenServer.call(@name, :pop)

  def push(element), do: GenServer.cast(@name, {:push, element})

  def show, do: GenServer.call(@name, :show)
  # impl
  def init(_), do: {:ok, Stack.Stash.get()}

  def handle_call(:show, _from, list), do: {:reply, list, list}

  def handle_call(:pop, _from, [head | tail]), do: {:reply, head, tail}

  def handle_cast({:push, element}, list) do
    {:noreply, [element + element] ++ list}
  end

  def terminate(_reason, current_list) do
    Stack.Stash.update(current_list)
  end
end
