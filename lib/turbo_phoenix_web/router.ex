defmodule TurboPhoenixWeb.Router do
  use TurboPhoenixWeb, :router
  import Phoenix.LiveDashboard.Router

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

  scope "/", TurboPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/signup/:stage", PageController, :stage
    post "/signup/:stage", PageController, :validate
  end

  if Mix.env() == :dev do
    scope "/", TurboPhoenixWeb do
      pipe_through :browser
      live_dashboard "/dashboard"
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", TurboPhoenixWeb do
  #   pipe_through :api
  # end
end
