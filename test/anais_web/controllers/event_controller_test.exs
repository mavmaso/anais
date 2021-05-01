defmodule AnaisWeb.EventControllerTest do
  use AnaisWeb.ConnCase

  import Anais.Factory

  # @create_attrs %{title: "some email", description: "some name"}

  # @invalid_attrs %{title: nil, description: nil}

  setup %{conn: conn} do
    author = insert(:author)

    {:ok, conn: put_req_header(conn, "accept", "application/json"), author: author}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      event = insert(:event)

      conn = get(conn, Routes.event_path(conn, :index))

      assert [expected] = json_response(conn, 200)["data"]
      assert expected["title"] == event.title
    end
  end
end
