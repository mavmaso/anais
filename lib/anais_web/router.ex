defmodule AnaisWeb.Router do
  use AnaisWeb, :router

  alias Anais.Guardian

  pipeline :jwt_auth do
    plug Guardian.AuthPipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AnaisWeb do
    pipe_through :api

    resources "/authors", AuthorController, only: [:create, :show]
    resources "/events", EventController, only: [:index]
    resources "/articles", ArticleController, only: [:index, :show]

    post "/login", AuthorController, :login
  end

  scope "/api", AnaisWeb do
    pipe_through [:api, :jwt_auth]

    resources "/authors", AuthorController, only: [:index]
    resources "/articles", ArticleController, only: [:create, :update]

    resources "/events", EventController, only: [:create] do
      post "/proceedings", EventController, :gen_pdf
    end
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: AnaisWeb.Telemetry
    end
  end
end
