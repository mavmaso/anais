defmodule Anais.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :email, :string
      add :password, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:authors, [:email])
  end
end
