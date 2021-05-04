defmodule AnaisWeb.SessionControllerTest do
  use AnaisWeb.ConnCase

  import Anais.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "login" do
    test "a author, returns status :ok", %{conn: conn} do
      author = insert(:author)
      params = %{email: author.email, password: "somepassword"}

      conn = post(conn, Routes.session_path(conn, :login, params))

      assert jwt = json_response(conn, 200)["data"]["jwt"]
      assert jwt =~ "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9"
    end

    test "can't invalid password, returns 400", %{conn: conn} do
      author = insert(:author)
      params = %{email: author.email, password: "errado"}

      conn = post(conn, Routes.session_path(conn, :login, params))

      assert %{"detail" => "Unauthorized"} = json_response(conn, 401)["errors"]
    end
  end
end
