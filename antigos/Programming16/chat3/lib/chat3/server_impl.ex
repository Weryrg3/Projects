defmodule Chat3.ServerImpl do
  def new_user(new_user, pid_user, map) do
      map
      |> Map.put(new_user, pid_user)
      |> Map.put(pid_user, new_user)
  end
end
