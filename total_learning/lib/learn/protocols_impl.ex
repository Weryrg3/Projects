# Este file faz parte da aplicação
# do Learn, aqui irei usar protocols e implementação
# que foram usados em mix, porém, é claro alterados."

defprotocol Learn.ProtocolsImpl do
  def info(arg)
end

defimpl Learn.ProtocolsImpl, for: Learn.Struct2 do
  def info(arg), do: arg.string
end

defimpl Learn.ProtocolsImpl, for: Learn.Struct1 do
  def info(arg), do: arg.name
end
