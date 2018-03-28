defmodule Novo.Thing2DynamicSup do
  use DynamicSupervisor
  @me __MODULE__

  def start_link(_) do
    DynamicSupervisor.start_link(@me, :no_args, name: @me)
  end

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_worker do
    {:ok, _pid} = DynamicSupervisor.start_child(@me, Novo.Workers)
  end
end
