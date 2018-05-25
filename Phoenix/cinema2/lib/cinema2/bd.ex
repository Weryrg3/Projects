defmodule Cinema2.BD do
  alias Cinema2.{Usuario, Repo}

  def changeset(usuario_params \\ nil) do
    if usuario_params do
      Usuario.changeset(%Usuario{}, usuario_params)
    else
      Usuario.changeset(%Usuario{})
    end
  end

  def inserir_usuario(usuario_params) do
    changeset = changeset(usuario_params)
    {:ok, usuario} = Repo.insert(changeset)
    usuario
  end
end
