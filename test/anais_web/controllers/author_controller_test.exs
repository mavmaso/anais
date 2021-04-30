defmodule AnaisWeb.AuthorControllerTest do
  use AnaisWeb.ConnCase

  import Anais.Factory

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
      author = insert(:author)

      conn =
        login(conn, author)
        |> get(Routes.author_path(conn, :index))

      assert [expected] = json_response(conn, 200)["data"]
      assert expected["email"] == author.email
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

  describe "login" do
    test "a author, returns status :ok", %{conn: conn} do
      author = insert(:author)
      params = %{email: author.email, password: "somepassword"}

      conn = post(conn, Routes.author_path(conn, :login, params))

      assert jwt = json_response(conn, 200)["data"]["jwt"]
      assert jwt =~ "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9"
    end

    test "can't invalid password, returns 400", %{conn: conn} do
      author = insert(:author)
      params = %{email: author.email, password: "errado"}

      conn = post(conn, Routes.author_path(conn, :login, params))

      assert %{"detail" => "Unauthorized"} = json_response(conn, 401)["errors"]
    end
  end
end
