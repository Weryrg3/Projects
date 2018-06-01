defmodule Cinema3.FilmeTest do
  use Cinema3.ModelCase
  alias Cinema3.Filme

  @params %{
    "nome" => "testando",
    "ano" => "101220",
    "sinopse" => "testando",
    "elenco" => "testando",
    "formato" => "testando",
    "duracao" => "testando",
    "categoria" => "testando",
    "classificacao" => "testando"
  }

  test "Testa changeset com valores válidos e inválidos" do
    assert %{valid?: true} = Filme.changeset(%Filme{}, @params)
    assert %{valid?: false} = Filme.changeset(%Filme{}, %{})
    assert %{valid?: false} = Filme.changeset(%Filme{})
  end
end
