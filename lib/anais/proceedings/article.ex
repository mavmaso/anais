defmodule Anais.Proceedings.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :abstract, :string
    field :title, :string
    field :keywords, {:array, :string}

    belongs_to :event, Anais.Proceedings.Event
    belongs_to :author, Anais.Account.Author

    many_to_many(:co_authors, Anais.Account.Author,
      join_through: "co_authors",
      on_replace: :delete,
      on_delete: :delete_all
    )

    timestamps()
  end

  @required ~w(title abstract author_id event_id keywords)a

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> maybe_put_assoc_co_authors(attrs)
  end

  defp maybe_put_assoc_co_authors(changeset, %{"co_authors" => _co_authors} = attrs) do
    put_assoc(changeset, :co_authors, Anais.Account.list_author(attrs["co_authors"]))
  end

  defp maybe_put_assoc_co_authors(changeset, %{co_authors: _co_authors} = attrs) do
    put_assoc(changeset, :co_authors, Anais.Account.list_author(attrs[:co_authors]))
  end

  defp maybe_put_assoc_co_authors(changeset, _) do
    changeset
  end
end
