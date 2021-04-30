defmodule Anais.Account.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @required ~w(email password name)a

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, @required)
    |> validate_required( @required)
    |> unique_constraint(:email)
    |> put_password()
  end

  defp put_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password(changeset), do: changeset
end
