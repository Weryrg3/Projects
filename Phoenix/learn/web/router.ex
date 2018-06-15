defmodule Learn.Router do
  use Learn.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Learn.TestePlug, :algo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Learn do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/plug/:p", PlugConnAssignsController, :index
    get "/calculadora/:op", CalculadoraController, :index
    get "/form/teste1", FormController, :teste1
    resources "/testes", TestesController, only: [:index, :create]
    resources "/form", FormController
    resources "/novostestes", NovosTestesController
    get "/novostestes/testes/links", NovosTestesController, :links
    resources "/relacionamentos", RelacionamentosController

    scope "/testes" do
      # pipe_through [:browser]
      # pipe_through [:browser, :teste1_plug] # plug sobrescreve put_flash do plug router
      get "/teste1", TestesController, :teste1
      get "/teste2", TestesController, :teste2
      get "/teste_css", TestesController, :teste_css
    end
  end



  # Other scopes may use custom stacks.
  # scope "/api", Learn do
  #   pipe_through :api
  # end
end
