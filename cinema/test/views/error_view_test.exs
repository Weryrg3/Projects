defmodule Cinema.ErrorViewTest do
  use Cinema.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(Cinema.ErrorView, "404.html", []) ==
           "Página não encontrada, continue procurando jovem padwin"
  end

  test "render 500.html" do
    assert render_to_string(Cinema.ErrorView, "500.html", []) ==
           "Internal server error, Deu erro aqui OH!!"
  end

  test "render any other" do
    assert render_to_string(Cinema.ErrorView, "505.html", []) ==
           "Internal server error, Deu erro aqui OH!!"
  end
end
