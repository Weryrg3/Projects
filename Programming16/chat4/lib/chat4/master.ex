defmodule Chat4.Master do
  use GenServer
  # require Logger

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
    # Logger.info("Iniciando Master")
    IO.puts("Iniciando Servidor")
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

  def handle_info({:reconnect, client}, state) do
    new_state = %{clients: [client | state.clients]}
    {:noreply, new_state}
  end

  def handle_info({:message_all, _, _, _, _}, state = %{clients: []}) do
    {:noreply, state}
  end

  def handle_info({:message_all, message, name_sender, _pid_sender, pid_print}, state) do
    Enum.each(state.clients, fn client ->
      if client.pid_print != pid_print do
        send(client.pid_print, {:all, message, name_sender})
      end
    end)

    {:noreply, state}
  end

  def handle_info({:private, message, name_sender, _pid_sender, pid_print, name_receive}, state) do
    if Enum.any?(state.clients, fn map -> map.user_name == name_receive end) do
      Enum.each(state.clients, fn map ->
        if map.user_name == name_receive do
          send(map.pid_print, {:private, message, name_sender})
        end
      end)
    else
      send(pid_print, {:server_message, "Usuário não encontrado"})
    end

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
