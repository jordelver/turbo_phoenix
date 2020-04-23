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

  pipeline :admins_only do
    # if basic auth credentials are present turn it on
    if System.get_env("HTTP_BASIC_AUTH_USERNAME") || System.get_env("HTTP_BASIC_AUTH_PASSWORD") do
      plug BasicAuth, use_config: {:turbo_phoenix_web, :basic_auth}
    end
  end

  scope "/", TurboPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/signup/:stage", PageController, :stage
    post "/signup/:stage", PageController, :validate
  end

  scope "/", TurboPhoenixWeb do
    pipe_through [:browser, :admins_only]
    live_dashboard "/dashboard", metrics: TurboPhoenixWeb.Telemetry
  end

  # Other scopes may use custom stacks.
  # scope "/api", TurboPhoenixWeb do
  #   pipe_through :api
  # end
end
