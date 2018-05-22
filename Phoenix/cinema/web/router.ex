defmodule Cinema.Router do
  use Cinema.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Cinema.Auth, repo: Cinema.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Cinema do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/user", UserController
    resources "/sessions", SessionController
  end

  scope "/manage", Cinema do
    pipe_through [:browser]

    resources "/videos", VideoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Cinema do
  #   pipe_through :api
  # end
end
