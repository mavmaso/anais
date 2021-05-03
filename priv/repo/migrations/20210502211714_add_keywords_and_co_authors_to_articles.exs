defmodule Anais.Repo.Migrations.AddKeywordsAndCoAuthorsToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :keywords, {:array, :string}
    end

    create table(:co_authors, primary_key: false) do
      add :article_id, references(:articles, on_delete: :nothing, primary_key: true)
      add :author_id, references(:authors, on_delete: :nothing, primary_key: true)

      timestamps(type: :utc_datetime, default: fragment("timezone('utc', now())"))
    end

    create index(:co_authors, [:article_id])
    create index(:co_authors, [:author_id])
  end
end
