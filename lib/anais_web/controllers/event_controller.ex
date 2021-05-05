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

  def show(conn, %{"id" => id}) do
    event = Proceedings.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def gen_pdf(conn, %{"event_id" => id}) do
    with %Event{} = event <- Proceedings.get_event!(id),
     {:ok, template} <- Proceedings.pdf_template(event),
     {:ok, filename} <- PdfGenerator.generate(template, delete_temporary: true) do
      conn
      |> put_status(:created)
      |> json(%{data: "Pdf has been stored in #{filename}"})
    end
  end
end
