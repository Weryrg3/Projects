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
    get "/test1", Teste1Controller, :show
    get "/test2", Teste2Controller, :teste2
    get "/test2/:test0", Teste3Controller, :teste3
    get "/test1/:name", Teste4Controller, :teste4
  end

  # Other scopes may use custom stacks.
  # scope "/api", Learn do
  #   pipe_through :api
  # end
end
