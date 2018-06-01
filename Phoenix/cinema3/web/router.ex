defmodule Cinema3.Router do
  use Cinema3.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Cinema3.Autenticar, repo: Cinema3.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Cinema3 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/usuario", UsuarioController
    resources "/sessao", SessaoController
    resources "/filmes", FilmeController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Cinema3 do
  #   pipe_through :api
  # end
end
