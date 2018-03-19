defmodule Chat do
  @moduledoc """
  Documentation for Chat.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Chat.hello
      :world

  """
  def hello do
    :world
  end
end

# Aplicação de bots que conversam e respondam
# o usuário inicia um bot, depois outro, então envia mensagem de um para o outro
# e recebe uma resposta
# quando tiver 1 ou mais bots # fulano de tal entrou envie uma mensagem para ele!!
# bots automaticos
# pessoa saiu da sala
# implementar @todos para evitar o segundo IO.gets exemplo enviar mensagem: OI pessoal @todos
# String.contains?
# implementar @user para enviar para um usúario especifico, problemas que ficam no caminho, como pegar até o espaço
# Chat.iniciar_client("Wesley", Chat.iniciar_server)
# implementar todos enviar todos exceto quem está enviando
