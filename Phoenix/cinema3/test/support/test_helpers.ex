defmodule Cinema3.TestHelpers do
  alias Cinema3.{Repo, Usuario}

  def inserir_usuario(attrs \\ %{}) do
    changes =
      Map.merge(%{
        username: "username",
        nome: "algum nome",
        cpf: "00000000000",
        rg: "0000000",
        telefone: "000000000",
        endereco: "algum enderoco",
        senha: "000000",
        senha_confirm: "000000"
      }, attrs)
    %Usuario{}
    |> Usuario.registrar_changeset(changes)
    |> Repo.insert!()
  end
end
