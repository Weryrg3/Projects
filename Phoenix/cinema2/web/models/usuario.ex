defmodule Cinema2.Usuario do
  use Cinema2.Web, :model

  schema "usuarios" do
    field(:username, :string)
    field(:nome, :string)
    field(:cpf, :string)
    field(:rg, :string)
    field(:endereco, :string)
    field(:telefone, :string)
    field(:senha, :string, virtual: true)
    field(:senha_confirm, :string, virtual: true)
    field(:senha_hash, :string)
    timestamps()
  end

  @params ~w(username nome cpf rg endereco telefone)a

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @params, [])
    |> validate_length(:username, min: 3, max: 25)
    |> validate_length(:cpf, is: 11)
    |> validate_length(:rg, is: 7)
    |> unique_constraint(:username)
    |> unique_constraint(:cpf)
    |> unique_constraint(:rg)
  end
end
