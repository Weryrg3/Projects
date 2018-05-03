defmodule TaskAgent do
  alias TaskAgent.Agent.{List, Map}
  alias TaskAgent.Task.{ShowList, ShowMap}
  alias TaskAgent.Supervisor.{GenGenServer, GenSupervisor}
  alias TaskAgent.Application, as: App

  def gen_new_number(num) do
    GenGenServer.new_number(num)
  end

  def list_add_elem_begin(elem) do
    List.add_elem_begin(elem)
  end

  def list_add_elem_final(elem) do
    List.add_elem_final(elem)
  end

  def map_add_elem(key, elem) do
    Map.add_elem(key, elem)
  end

  def list_size do
    List.size()
  end

  def map_size do
    Map.size()
  end

  def gen_show do
    GenGenServer.show()
  end

  def list_show do
    List.elements()
  end

  def map_show do
    Map.elements()
  end

  def gen_kill do
    GenGenServer.kill()
  end

  def sup_kill do
    GenSupervisor.kill()
  end

  def list_kill do
    ShowList.kill()
    List.kill()
  end

  def map_kill do
    ShowMap.kill()
    Map.kill()
  end

  def kill_all do
    GenSupervisor.kill()
    GenGenServer.kill()
    ShowList.kill()
    ShowMap.kill()
    List.kill()
    Map.kill()
    App.kill()
  end
end
