defmodule AnaisWeb.EventView do
  use AnaisWeb, :view

  alias AnaisWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      title: event.title,
      description: event.description
    }
  end
end
