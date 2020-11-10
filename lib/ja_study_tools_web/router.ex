defmodule JaStudyToolsWeb.Router do
  use JaStudyToolsWeb, :router
  use Pow.Phoenix.Router

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

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :admin do
    plug JaStudyToolsWeb.EnsureRolePlug, :admin
  end

  pipeline :admin_layout do
    plug :put_layout, {JaStudyToolsWeb.LayoutView, :admin}
  end
  
  scope "/" do
    pipe_through :browser
    pow_routes()
  end

  scope "/", JaStudyToolsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/dictionary", PageController, :dictionary
  end

  scope "/", JaStudyToolsWeb do
    pipe_through [:browser, :protected]
  end

  scope "/admin", JaStudyToolsWeb.Admin do
    pipe_through [:browser, :protected, :admin, :admin_layout]
    get "/", PageController, :index
    get "/import", PageController, :import
    post "/import", PageController, :import
  end

  scope "/api/v1", JaStudyToolsWeb.API do
    pipe_through :api
    post "/dictionary/search", SearchController, :index
    get "/kanji", KanjiController, :index
    get "/vocab", VocabController, :index
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
      live_dashboard "/dashboard", metrics: JaStudyToolsWeb.Telemetry
    end
  end
end
