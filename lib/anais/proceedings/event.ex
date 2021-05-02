defmodule Anais.Proceedings.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :title, :string

    has_many :articles, Anais.Proceedings.Article

    timestamps()
  end

  @required ~w(title description)a
  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
