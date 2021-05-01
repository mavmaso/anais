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
end
