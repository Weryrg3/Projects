defmodule Chat4.Master do
  use GenServer
  require Logger

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: {:global, __MODULE__})
    |> case do
      {:ok, pid} ->
        {:ok, pid}

      {:error, {:already_started, pid}} ->
        Process.link(pid)
        {:ok, pid}
    end
  end

  def init(_arg) do
    Logger.info("Iniciando Master")
    {:ok, %{clients: []}}
  end

  def handle_info({:register, user_name, pid_print, pid_input}, state) do
    if Enum.any?(state.clients, fn map -> map.user_name == user_name end) do
      send(pid_print, {:server_message, "Já existe um usúario com esse nome"})
      send(pid_input, :already_exits)

      {:noreply, state}
    else
      send(pid_print, {:server_message, "Entrando no Servidor padrão"})
      send(pid_input, :start)

      client = %{user_name: user_name, pid_print: pid_print, pid_input: pid_input}
      new_state = %{clients: [client | state.clients]}

      {:noreply, new_state}
    end
  end

  def handle_info({:message_all, _message, user_name, pid_input, pid_print}, %{clients: []}) do
    {:noreply, %{clients: [%{pid_input: pid_input, pid_print: pid_print, user_name: user_name}]}}
  end

  def handle_info({:message_all, message, name_sender, _pid_sender, _pid_mprint}, state) do
    Enum.each(state.clients, fn client -> send(client.pid_print, {:all, message, name_sender}) end)

    {:noreply, state}
  end
end

# %{
#   clients: [
#     %{pid_input: 18, pid_print: 789, user_name: "Teste2"},
#     %{pid_input: 456, pid_print: 123, user_name: "Teste1"},
#     %{pid_input: 489, pid_print: 758, user_name: "Teste3"},
#     %{pid_input: 257, pid_print: 349, user_name: "Teste4"}
#   ]
# }
