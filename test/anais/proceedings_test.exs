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

    test "pdf_template/1 returns a :ok" do
      article = insert(:article)
      event = article.event
      # article_b = insert(:article, event: event)

      assert {:ok, subject} = Proceedings.pdf_template(event)

      assert subject =~ "<h1><b>#{event.title}<b>"
      # assert subject =~ "<h2>#{article.title}"
      # assert subject =~ "<h2>#{article_b.title}"
      # assert subject =~ "<p>#{article.abstract}"
    end
  end

  describe "articles" do
    alias Anais.Proceedings.Article

    @update_attrs %{abstract: "some updated abstract", title: "some updated title"}

    @invalid_attrs %{abstract: nil, title: nil}

    test "list_articles/0 returns all articles" do
      article = insert(:article)

      assert [subject] = Proceedings.list_articles()
      assert subject.id == article.id
    end

    test "get_article!/1 returns the article with given id" do
      article = insert(:article)

      assert subject = Proceedings.get_article!(article.id)
      assert subject.id == article.id
    end

    test "create_article/1 with valid data creates a article" do
      ca = insert(:author)
      params = params_with_assocs(:article) |> Map.merge(%{co_authors: [ca.id]})

      assert {:ok, %Article{} = article} = Proceedings.create_article(params)
      assert article.abstract == params.abstract
      assert article.title == params.title
      assert article.keywords == params.keywords
      assert List.first(article.co_authors).id == ca.id
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Proceedings.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = insert(:article)
      assert {:ok, %Article{} = article} = Proceedings.update_article(article, @update_attrs)
      assert article.abstract == "some updated abstract"
      assert article.title == "some updated title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = insert(:article)

      assert {:error, %Ecto.Changeset{}} = Proceedings.update_article(article, @invalid_attrs)
    end

    test "delete_article/1 deletes the article" do
      article = insert(:article)
      assert {:ok, %Article{}} = Proceedings.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Proceedings.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = insert(:article)
      assert %Ecto.Changeset{} = Proceedings.change_article(article)
    end
  end
end
