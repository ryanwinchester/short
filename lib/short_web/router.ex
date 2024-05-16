defmodule ShortWeb.Router do
  use ShortWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ShortWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShortWeb do
    pipe_through :browser

    live "/urls", URLLive.Index, :index
    live "/urls/new", URLLive.Index, :new
    live "/urls/:id/edit", URLLive.Index, :edit
    live "/urls/:id", URLLive.Show, :show
    live "/urls/:id/show/edit", URLLive.Show, :edit

    get "/", PageController, :index
    get "/:short", PageController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShortWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:short, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ShortWeb.Telemetry
    end
  end
end
