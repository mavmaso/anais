defmodule Anais.ProceedingsTest do
  use Anais.DataCase

  import Anais.Factory

  alias Anais.Proceedings

  describe "events" do
    alias Anais.Proceedings.Event

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    test "list_events/0 returns all events" do
      event = insert(:event)
      assert Proceedings.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = insert(:event)
      assert Proceedings.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Proceedings.create_event(@valid_attrs)
      assert event.description == "some description"
      assert event.title == "some title"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Proceedings.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = insert(:event)
      assert {:ok, %Event{} = event} = Proceedings.update_event(event, @update_attrs)
      assert event.description == "some updated description"
      assert event.title == "some updated title"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = insert(:event)
      assert {:error, %Ecto.Changeset{}} = Proceedings.update_event(event, @invalid_attrs)
      assert event == Proceedings.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = insert(:event)
      assert {:ok, %Event{}} = Proceedings.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Proceedings.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = insert(:event)
      assert %Ecto.Changeset{} = Proceedings.change_event(event)
    end
  end

  describe "articles" do
    alias Anais.Proceedings.Article

    @valid_attrs %{abstract: "some abstract", title: "some title"}
    @update_attrs %{abstract: "some updated abstract", title: "some updated title"}
    @invalid_attrs %{abstract: nil, title: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Proceedings.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Proceedings.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Proceedings.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Proceedings.create_article(@valid_attrs)
      assert article.abstract == "some abstract"
      assert article.title == "some title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Proceedings.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Proceedings.update_article(article, @update_attrs)
      assert article.abstract == "some updated abstract"
      assert article.title == "some updated title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Proceedings.update_article(article, @invalid_attrs)
      assert article == Proceedings.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Proceedings.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Proceedings.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Proceedings.change_article(article)
    end
  end
end
