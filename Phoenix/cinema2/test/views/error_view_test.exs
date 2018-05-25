defmodule Cinema2.ErrorViewTest do
  use Cinema2.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(Cinema2.ErrorView, "404.html", []) ==
           "Página não encontrada"
  end

  test "render 500.html" do
    assert render_to_string(Cinema2.ErrorView, "500.html", []) ==
           "Erro interno do servidor"
  end

  test "render any other" do
    assert render_to_string(Cinema2.ErrorView, "505.html", []) ==
           "Erro interno do servidor"
  end
end
