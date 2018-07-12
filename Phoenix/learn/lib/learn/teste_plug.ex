defmodule Learn.TestePlug do
  @moduledoc false
  # import Plug.Conn
  import Phoenix.Controller

  def init(params) do
    params
  end

  def call(conn, _params) do
    local = Enum.join([conn.host, conn.port], ":")
    path = Enum.join([local] ++ conn.path_info, "/")
    conn
    |> put_flash(:info, "#{path} -- Método: #{conn.method}")
  end

  def teste1_plug(conn, _arg) do
    local = Enum.join([conn.host, conn.port], ":")
    path = Enum.join([local] ++ conn.path_info, "/")

    conn
    |> put_flash(:info, path)
  end
end
