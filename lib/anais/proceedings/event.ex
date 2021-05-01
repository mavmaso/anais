defmodule Anais.Proceedings.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
