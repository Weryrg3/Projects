defmodule Sequence.Server0 do
  use GenServer

  def init(initial_elements) do
    {:ok, initial_elements}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    {:reply, new_number, new_number}
  end

  def handle_call(:next_element, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:next_element, _from, []) do
    {:reply, nil, []}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def handle_cast({:push_element, element}, list) do
    {:noreply, list ++ [element]}
  end

  def handle_cast({:pop_element, element}, list) do
    {:noreply, list -- [element]}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end

# OTP-Servers-1 ??? era isso?
    # {:ok, pid1} = GenServer.start_link(Sequence.Server, [5, "cat", 9])
    # GenServer.call(pid1, :next_element)
# OTP-Servers-2
