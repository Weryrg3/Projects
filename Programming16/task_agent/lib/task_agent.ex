defmodule TaskAgent do
  alias TaskAgent.Agent.{List, Map}
  alias TaskAgent.Task.{ShowList, ShowMap}
  alias TaskAgent.Supervisor.{GenGenServer, GenSupervisor}


  def gen_new_number(num) do
    GenGenServer.new_number(num)
  end

  def add_elem_list_begin(elem) do
    List.add_elem_begin(elem)
  end

  def add_elem_list_final(elem) do
    List.add_elem_final(elem)
  end

  def add_elem_map(key, elem) do
    Map.add_elem(key, elem)
  end

  def size_list do
    List.size()
  end

  def size_map do
    Map.size()
  end

  def gen_show do
    GenGenServer.show()
  end

  def show_list do
    List.elements()
  end

  def show_map do
    Map.elements()
  end

  def gen_kill do
    GenGenServer.kill()
  end

  def sup_kill do
    GenSupervisor.kill()
  end

  def kill_list do
    ShowList.kill()
    List.kill()
  end

  def kill_map do
    ShowMap.kill()
    Map.kill()
  end
end
