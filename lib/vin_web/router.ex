defmodule VinWeb.Router do
  use VinWeb, :router

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

  scope "/", VinWeb do
    pipe_through :browser

    get "/page", PageController, :index
  end

  scope "/", Absinthe do
    pipe_through :api
    forward "/api", Plug, schema: VinWeb.Schema

    if Mix.env() in [:dev, :test] do
      forward "/",
        Plug.GraphiQL,
        schema: VinWeb.Schema,
        interface: :advanced,
        socket: VinWeb.UserSocket
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: VinWeb.Telemetry
    end
  end
end
