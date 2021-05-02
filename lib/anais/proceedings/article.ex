defmodule Anais.Proceedings.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :abstract, :string
    field :title, :string

    belongs_to :event, Anais.Proceedings.Event
    belongs_to :author, Anais.Account.Author

    timestamps()
  end

  @required ~w(title abstract author_id event_id)a

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
