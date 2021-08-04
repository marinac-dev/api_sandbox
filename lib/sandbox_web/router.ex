defmodule SandboxWeb.Router do
  use SandboxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SandboxWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug SandboxWeb.Auth
  end

  scope "/", SandboxWeb do
    pipe_through :browser
    import Phoenix.LiveDashboard.Router

    live "/", PageLive, :index
    live_dashboard "/dashboard", metrics: SandboxWeb.Telemetry
  end

  scope "/", SandboxWeb do
    pipe_through [:api, :auth]

    get "/accounts", ApiController, :accounts_index
    get "/accounts/:account_id", ApiController, :accounts_get

    get "/accounts/:account_id/transactions", ApiController, :transactions_index
    get "/accounts/:account_id/transactions/:transaction_id", ApiController, :transactions_get
  end
end
