defmodule Learn.BD do
  @moduledoc """
  Banco de dados geral.
  """
  alias Learn.Repo

  @doc "Insere dados no banco de dados."
  def insert_data(changeset) do
    Repo.insert(changeset)
  end

  @doc "Lista todos arquivos do banco de dados."
  def get_all_files(struct) do
    Repo.all(struct)
  end

  @doc "pega um arquivo por ID."
  def get_file_by_id(struct, id) do
    # ! valores de saída não são tratados
    Repo.get!(struct, id)
  end

  @doc "pega um arquivo para parâmetros passados"
  def get_file_by(struct, param) do
    Repo.get_by(struct, param)
  end

  @doc "atualiza um arquivo."
  def update_file(changeset) do
    Repo.update(changeset)
  end

  @doc "remove todos arquivos."
  def delete_all(struct) do
    Repo.delete_all(struct)
  end

  @doc "remove um arquivo."
  def delete_file(struct) do
    Repo.delete!(struct)
  end

  @doc "pre carrega um arquivo relacionado"
  def preload(struct, atom) do
    Repo.preload(struct, atom)
  end

end
