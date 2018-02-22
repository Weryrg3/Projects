defprotocol Test.Protocols do
  def names(name)
end

defmodule Test1 do
  defstruct [:empresa]

  def new(empresa) do
    %Test1{empresa: empresa}
  end
end

defimpl Test.Protocols, for: Test1 do
  def names(name_empresa), do: IO.puts("Você digitou o nome da empresa #{name_empresa.empresa}")
end

defmodule Test2 do
  defstruct [:escola]

  def new(escola) do
    %Test2{escola: escola}
  end
end

defimpl Test.Protocols, for: Test2 do
  def names(name_escola), do: IO.puts("Vocẽ digitou o nome da sua escola #{name_escola.escola}")
end

defmodule Test3 do
  defstruct [:test]
  def new(test) do
    %Test3{test: test}
  end
end

defimpl Test.Protocols, for: Test3 do
  def names(name_test), do: IO.puts("Teste final #{name_test.test}")
end

defmodule Test4 do
  defstruct [:test]
  def new(test) do
    %Test4{test: test}
  end
end

defimpl Test.Protocols, for: Test4 do
  def names(name_test), do: IO.puts("Teste final2 #{name_test.test}")
end