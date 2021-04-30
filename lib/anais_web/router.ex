defmodule AnaisWeb.Router do
  use AnaisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AnaisWeb do
    pipe_through :api

    resources "/authors", AuthorController, except: [:new, :edit, :update, :delete]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: AnaisWeb.Telemetry
    end
  end
end
