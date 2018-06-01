defmodule Cinema3.Usuario do
  use Cinema3.Web, :model

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
    has_many(:filmes, Cinema3.Filme)
    timestamps()
  end

  @allowed ~w(username nome cpf rg endereco telefone)a

  def changeset(model, usuario_params \\ %{}) do
    model
    |> cast(usuario_params, @allowed)
    |> validate_required(@allowed)
    |> validate_length(:username, min: 3, max: 25)
    |> validate_length(:cpf, is: 11)
    |> validate_length(:rg, is: 7)
    |> unique_constraint(:username)
    |> unique_constraint(:cpf)
    |> unique_constraint(:rg)
  end

  def registrar_changeset(model, usuario_params) do
    model
    |> changeset(usuario_params)
    |> cast(usuario_params, [:senha])
    |> validate_required(:senha)
    |> validate_length(:senha, min: 5, max: 100)
    |> criptografar()
  end

  defp criptografar(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{senha: senha}} ->
        put_change(changeset, :senha_hash, Comeonin.Bcrypt.hashpwsalt(senha))

      _ ->
        changeset
    end
  end
end
