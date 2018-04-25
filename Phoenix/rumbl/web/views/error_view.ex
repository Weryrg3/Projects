defmodule Rumbl.ErrorView do
  use Rumbl.Web, :view

  def render("404.html", _assigns) do
    "Página não encontrada, continue procurando jovem padwin"
  end

  def render("500.html", _assigns) do
    "Internal server error, Deu erro aqui OH!!"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render("500.html", assigns)
  end
end
