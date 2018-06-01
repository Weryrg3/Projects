defmodule Cinema3.BD do
  alias Cinema3.{Usuario, Repo, Filme}

  def changeset_usuario(usuario_params \\ nil) do
    if usuario_params do
      Usuario.registrar_changeset(%Usuario{}, usuario_params)
    else
      Usuario.changeset(%Usuario{})
    end
  end

  def changeset_filme(filme_params \\ nil) do
    if filme_params do
      Filme.changeset(%Filme{}, filme_params)
    else
      Filme.changeset(%Filme{})
    end
  end

  def inserir_usuario(usuario_params) do
    changeset = changeset_usuario(usuario_params)
    Repo.insert(changeset)
  end

  def inserir_filme(filme_params) do
    changeset = changeset_filme(filme_params)
    Repo.insert(changeset)
  end

  def todo(param) do
    Repo.all(param)
  end
end
