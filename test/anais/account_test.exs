defmodule Anais.AccountTest do
  use Anais.DataCase

  import Anais.Factory

  alias Anais.Account

  describe "authors" do
    alias Anais.Account.Author

    @valid_attrs %{email: "some email", name: "some name", password: "some password"}

    @update_attrs %{
      email: "some updated email",
      name: "some updated name",
      password: "some updated password"
    }

    @invalid_attrs %{email: nil, name: nil, password: nil}


    test "list_authors/0 returns all authors" do
      author = insert(:author)
      assert Account.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = insert(:author)
      assert Account.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = Account.create_author(@valid_attrs)
      assert author.email == "some email"
      assert author.name == "some name"
      assert author.password =~ "$2b$04$"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = insert(:author)
      assert {:ok, %Author{} = author} = Account.update_author(author, @update_attrs)
      assert author.email == "some updated email"
      assert author.name == "some updated name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = insert(:author)
      assert {:error, %Ecto.Changeset{}} = Account.update_author(author, @invalid_attrs)
      assert author == Account.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = insert(:author)
      assert {:ok, %Author{}} = Account.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Account.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = insert(:author)
      assert %Ecto.Changeset{} = Account.change_author(author)
    end
  end
end
