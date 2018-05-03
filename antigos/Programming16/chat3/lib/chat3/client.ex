 defmodule Chat3.Client do
  def new_client do
    user_name = IO.gets("Digite o nome de usuário: ")
    |> String.trim()
    {user_name, self()}
  end
  #  def loop_messages do
    #  msg = IO.gets("Messagem: ") |> String.trim()
    #  who = IO.gets("Quem: ") |> String.trim()
  #  end
 end
