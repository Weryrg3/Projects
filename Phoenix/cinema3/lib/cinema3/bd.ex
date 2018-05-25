defmodule Cinema3.BD do
  alias Cinema3.{Usuario, Repo}

  def changeset(usuario_params \\ nil) do
    if usuario_params do
      Usuario.registrar_changeset(%Usuario{}, usuario_params)
    else
      Usuario.changeset(%Usuario{})
    end
  end

  def inserir_usuario(usuario_params) do
    changeset = changeset(usuario_params)
    Repo.insert(changeset)
  end
end
