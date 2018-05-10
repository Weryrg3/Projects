defmodule Cinema.User do
  use Cinema.Web, :model

  @fields [:username, :nome, :cpf, :rg, :cartao, :endereco, :telefone]

  schema "users" do
    field(:username, :string)
    field(:nome, :string)
    field(:cpf, :string)
    field(:rg, :string)
    field(:cartao, :string)
    field(:endereco, :string)
    field(:telefone, :string)
    field(:senha, :string, virtual: true)
    field(:senha_confirm, :string, virtual: true)
    field(:senha_hash, :string)
    field(:permission, :boolean, default: false)
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields, [])
    |> validate_required(@fields)
    |> validate_length(:username, min: 3, max: 20)
    |> validate_length(:cpf, is: 11)
    |> validate_length(:rg, is: 7)
    |> validate_length(:cartao, is: 16)
    |> unique_constraint(:username)
    |> unique_constraint(:cpf)
    |> unique_constraint(:rg)
  end

  def registrar_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, [:senha], [])
    |> validate_length(:senha, min: 6, max: 30)
    |> criptografia_hash()
  end

  defp criptografia_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{senha: pass}} ->
        put_change(changeset, :senha_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
