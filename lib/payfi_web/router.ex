defmodule PayfiWeb.Router do
  use PayfiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PayfiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PayfiWeb do
    pipe_through :browser

    # coveralls-ignore-start
    get "/", PageController, :home
    get "/openapi.yaml", ApiDocsController, :index
    get "/swagger", SwaggerController, :index
    # coveralls-ignore-stop
  end

  # Other scopes may use custom stacks.
  scope "/api", PayfiWeb do
    pipe_through :api

    post "/user/create", UserController, :create
    post "/participation/create", ParticipationController, :create
    post "/draw/create", DrawController, :create
    get "/draw/result/:id", DrawController, :get_result
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:payfi, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PayfiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
