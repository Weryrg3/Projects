defmodule BD.UserTest do
  # use ExUnit.Case
  use Cinema.ModelCase
  alias Cinema.DB

  @user_params %{
    "cpf" => "12345678921",
    "endereco" => "jklçkjasdf",
    "nome" => "Wesley",
    "rg" => "4545789",
    "senha" => "123456",
    "senha_confirm" => "123456",
    "telefone" => "465789456",
    "username" => "wery43"
  }

  @video_params %{
    ano: "2018",
    diretor: "Leornado Di Caprio",
    duracao: "2h:30",
    elenco: "Jose Ana Ezequiel",
    formato: "3D",
    genero: "Comédia",
    sinopse: "Alguma",
    subgenero: "term",
    titulo: "A vida",
    trailer: "hhww"
  }

  test "unique index user" do
    assert {:ok, _} = DB.insert_in_db_user(@user_params)
    assert {:error, _} = DB.insert_in_db_user(@user_params)
  end

  test "update bd" do
    {:ok, %{id: id}} = DB.insert_in_db_user(@user_params)
    assert {:ok, _} = DB.update_in_db_user(@user_params, id)
  end

  test "delete bd" do
    {:ok, %{id: id}} = DB.insert_in_db_user(@user_params)
    assert DB.delete_in_db_user(id)
  end
end
