defmodule TurboPhoenixWeb.Router do
  use TurboPhoenixWeb, :router

  alias TurboPhoenixWeb.RandomSleep

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RandomSleep
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TurboPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/name", PageController, :name
    get "/address", PageController, :address
    get "/confirm", PageController, :confirm
    get "/thanks", PageController, :thanks
  end

  # Other scopes may use custom stacks.
  # scope "/api", TurboPhoenixWeb do
  #   pipe_through :api
  # end
end
