defmodule Anais.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :abstract, :string
      add :author_id, references(:authors, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:articles, [:author_id])
    create index(:articles, [:event_id])
  end
end
