defmodule Learn.Router do
  use Learn.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Learn do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/plug/:p", PlugConnController, :index
    get "/calculadora/:op", CalculadoraController, :index
    get "/form/teste1", FormController, :teste1
    resources "/testes", TestesController, only: [:index, :create]
    resources "/form", FormController, only: [:index, :new, :create]

    scope "/testes" do
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
