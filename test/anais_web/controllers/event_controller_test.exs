defmodule AnaisWeb.EventControllerTest do
  use AnaisWeb.ConnCase

  import Anais.Factory

  @invalid_attrs %{title: nil, description: nil}

  defp create_event(_) do
    event = insert(:event)
    %{event: event}
  end

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

  describe "show" do
    test "render an event, returns :ok", %{conn: conn} do
      event = insert(:event)

      conn = get(conn, Routes.event_path(conn, :show, event.id))

      assert subject = json_response(conn, 200)["data"]
      assert subject["id"] == event.id
      assert subject["title"] == event.title
      assert subject["description"] == event.description
    end
  end

  describe "delete event" do
    test "deletes chosen event", %{conn: conn} do
      event = insert(:event)
      author = insert(:author)

      conn =
        login(conn, author)
        |> delete(Routes.event_path(conn, :delete, event))

      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get(conn, Routes.event_path(conn, :show, event))
      end
    end
  end

  describe "update event" do
    setup [:create_event]

    test "renders event when data is valid", %{conn: conn, event: %{id: id} = event} do
      author = insert(:author)
      params = params_for(:event)

      conn =
        login(conn, author)
        |> put(Routes.event_path(conn, :update, event), event: params)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.event_path(conn, :show, id))

      assert subject = json_response(conn, 200)["data"]
      assert subject["id"] == id
      assert subject["title"] == params.title
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      author = insert(:author)

      conn =
        login(conn, author)
        |> put(Routes.event_path(conn, :update, event), event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
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
