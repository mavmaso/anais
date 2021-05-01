defmodule AnaisWeb.ArticleControllerTest do
  use AnaisWeb.ConnCase

  import Anais.Factory

  # alias Anais.Proceedings
  alias Anais.Proceedings.Article

  @create_attrs %{
    abstract: "some abstract",
    title: "some title"
  }
  @update_attrs %{
    abstract: "some updated abstract",
    title: "some updated title"
  }
  @invalid_attrs %{abstract: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all articles", %{conn: conn} do
      conn = get(conn, Routes.article_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create article" do
    test "renders article when data is valid", %{conn: conn} do
      author = insert(:author)

      conn =
        login(conn, author)
        |> post(Routes.article_path(conn, :create), article: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.article_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "abstract" => "some abstract",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      author = insert(:author)

      conn =
        login(conn, author)
        |> post(Routes.article_path(conn, :create), article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update article" do
    setup [:create_article]

    test "renders article when data is valid", %{conn: conn, article: %Article{id: id} = article} do
      author = insert(:author)

      conn =
        login(conn, author)
        |> put(Routes.article_path(conn, :update, article), article: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.article_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "abstract" => "some updated abstract",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, article: article} do
      author = insert(:author)

      conn =
        login(conn, author)
        |> put(Routes.article_path(conn, :update, article), article: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_article(_) do
    article = insert(:article)
    %{article: article}
  end
end
