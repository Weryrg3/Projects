defmodule Novo.Thing1Supervisor do
  use Supervisor
  @me __MODULE__

  def start_link(arg) do
    Supervisor.start_link(@me, arg, name: @me)
  end

  def init(_arg) do
    children = [
      Novo.Thing2DynamicSup
    ]
    Supervisor.init(children, strategy: :rest_for_one)
  end
end
