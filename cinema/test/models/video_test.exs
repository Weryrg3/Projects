defmodule Cinema.VideoTest do
  use Cinema.ModelCase

  alias Cinema.Video

  @valid_attrs %{ano: "some content", classificacao: "some content", diretor: "some content", duracao: "some content", elenco: "some content", formato: "some content", genero: "some content", sinopse: "some content", subgenero: "some content", titulo: "some content", trailer: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Video.changeset(%Video{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Video.changeset(%Video{}, @invalid_attrs)
    refute changeset.valid?
  end
end
