defmodule Anais.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
