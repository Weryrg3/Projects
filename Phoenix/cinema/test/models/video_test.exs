defmodule Cinema.VideoTest do
  use Cinema.ModelCase

  alias Cinema.{Video, Categoria, Classificacao}

  @valid_attrs %{
    ano: "some content",
    diretor: "some content",
    duracao: "some content",
    elenco: "some content",
    formato: "some content",
    sinopse: "some content",
    titulo: "some content",
    trailer: "some content"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    categoria = Repo.insert!(%Categoria{nome: "Comédia"})
    classificacao = Repo.insert!(%Classificacao{nome: "L"})

    changeset =
      Video.changeset(
        %Video{categoria: categoria, classificacao: classificacao},
        @valid_attrs
      )

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Video.changeset(%Video{}, @invalid_attrs)
    refute changeset.valid?
  end
end
