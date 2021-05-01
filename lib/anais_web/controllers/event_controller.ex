defmodule AnaisWeb.EventController do
  use AnaisWeb, :controller

  alias Anais.Proceedings
  # alias Anais.Proceedings.Event

  action_fallback AnaisWeb.FallbackController

  def index(conn, _params) do
    events = Proceedings.list_events()
    render(conn, "index.json", events: events)
  end
end
