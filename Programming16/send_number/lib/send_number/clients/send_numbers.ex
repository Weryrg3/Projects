defmodule SendNumber.Clients.SendNumbers do
  alias SendNumber.Clients.{ReceiveNumbers, RandomName}
  use GenServer
  @me __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, [], name: @me)
    {:ok, pid_receive} = ReceiveNumbers.start_link(self())
    start(pid_receive)
  end

  def init(_arg) do
    {:ok, %{}}
  end

  def start(pid_receive) do
    name = RandomName.names
    main_server = :global.whereis_name(MainServer)

    send(main_server, {:register, name, pid_receive, self()})
    receive do
      :try_again ->
        start(pid_receive)
      :continue ->
        send(pid_receive, {:name, name})
        GenServer.call(@me, {:new_client, pid_receive, main_server})
        send(@me, :next)
    end
  end

  def handle_call({:new_client, pid_receive, main_server}, _from, state) do
    new_state =
      Map.put(state, :pid_receive, pid_receive) |> Map.put(:main_server, main_server)

    {:reply, new_state}
  end

  def handle_info(:next, state) do
    number = Enum.random(1..20)
    send(state.main_server, {:new_number, number, state.pid_receive})
  end
end
