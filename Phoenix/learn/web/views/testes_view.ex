defmodule Learn.TestesView do
  use Learn.Web, :view

  @string [
    "btn btn-link",
    "btn btn-default",
    "btn btn",
    "btn btn-primary",
    "btn btn-danger",
    "btn btn-success",
    "btn btn-info",
    "btn btn-warning"
  ]

  @string_c [
    "btn btn-danger",
    "btn btn-success",
    "btn btn-info",
    "btn btn-warning"
  ]

  @string1 [
    "cima",
    "baixo",
    "lado esquerdo",
    "lado direito"
  ]

  def random do
    Enum.random(@string)
  end

  def random1 do
    Enum.random(@string1)
  end

  def random_colors do
    Enum.random(@string_c)
  end
end
