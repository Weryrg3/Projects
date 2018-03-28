defmodule Chat3.ServerImpl do
  @server {:global, Server}

  def show do
    GenServer.call(@server, :show)
  end

  def novo(user_name, pid_name) do
    GenServer.cast(@server, {:new, user_name, pid_name})
  end
end
