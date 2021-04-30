defmodule AnaisWeb.AuthorControllerTest do
  use AnaisWeb.ConnCase

  # import Anais.Factory

  @create_attrs %{
    email: "some email",
    name: "some name",
    password: "somepassword"
  }

  @invalid_attrs %{email: nil, name: nil, password: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all authors", %{conn: conn} do
      conn = get(conn, Routes.author_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create author" do
    test "renders author when data is valid", %{conn: conn} do
      conn = post(conn, Routes.author_path(conn, :create), author: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.author_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some email",
               "name" => "some name",
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.author_path(conn, :create), author: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
