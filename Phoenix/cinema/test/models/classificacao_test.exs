defmodule Cinema.ClassificacaoTest do
  use Cinema.ModelCase

  alias Cinema.Classificacao

  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Classificacao.changeset(%Classificacao{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Classificacao.changeset(%Classificacao{}, @invalid_attrs)
    refute changeset.valid?
  end
end
