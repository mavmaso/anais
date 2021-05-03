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

  describe "create" do
    test "an event with valid date and returns :ok", %{conn: conn, author: author} do
      params =  string_params_for(:event)

      conn =
        login(conn, author)
        |> post(Routes.event_path(conn, :create, %{"event" => params}))

      assert subject = json_response(conn, 201)["data"]
      assert subject["title"] == params["title"]
      assert subject["description"] == params["description"]
    end
  end

  describe "gen_pdf" do
    test "based on a event with article, returns :ok", %{conn: conn, author: author} do
      %{event: event} = insert(:article)

      conn =
        login(conn, author)
        |> post(Routes.event_event_path(conn, :gen_pdf, event.id))

      assert subject = json_response(conn, 201)["data"]
      assert subject =~ "Pdf has been stored in"
    end

    test "based on a event without article, returns :error", %{conn: conn, author: author} do
      event = insert(:event)

      conn =
        login(conn, author)
        |> post(Routes.event_event_path(conn, :gen_pdf, event.id))

      assert json_response(conn, 400)
    end
  end
end
