defmodule Cinema3.UsuarioTest do
  use Cinema3.ModelCase
  import Comeonin.Bcrypt, only: [checkpw: 2]
  alias Cinema3.Usuario

  @params %{
    "username" => "We1",
    "nome" => "Wesley",
    "cpf" => "12345678945",
    "rg" => "1234789",
    "telefone" => "45698745",
    "endereco" => "rua das avenidas",
    "senha" => "123456",
    "senha_confirm" => "123456"
  }

  test "Testa changeset com valores válidos e inválidos" do
    assert %{valid?: true} = Usuario.changeset(%Usuario{}, @params)
    assert %{valid?: false} = Usuario.changeset(%Usuario{}, %{})
    assert %{valid?: false} = Usuario.changeset(%Usuario{})
  end

  test "Testa registrar_changeset com valores válidos e inválidos" do
    assert %{valid?: true} = Usuario.registrar_changeset(%Usuario{}, @params)
    assert %{valid?: false} = Usuario.registrar_changeset(%Usuario{}, %{})
  end

  test "Testa a criptografia" do
    %Ecto.Changeset{changes: %{senha: senha, senha_hash: senha_hash}} = Usuario.registrar_changeset(%Usuario{}, @params)
    assert checkpw(senha, senha_hash)
  end
end
