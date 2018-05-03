defmodule Learn2.Name do
  use Learn2.Web, :model

  schema "names" do
    field :name, :string
    timestamps()
  end
end
