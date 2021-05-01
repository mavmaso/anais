defmodule AnaisWeb.EventController do
  use AnaisWeb, :controller

  alias Anais.Proceedings
  alias Anais.Proceedings.Event

  action_fallback AnaisWeb.FallbackController

  def index(conn, _params) do
    events = Proceedings.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Proceedings.create_event(event_params) do
      conn
      |> put_status(:created)
      |> render("show.json", event: event)
    end
  end
end
