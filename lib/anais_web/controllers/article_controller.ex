defmodule AnaisWeb.ArticleController do
  use AnaisWeb, :controller

  alias Anais.Proceedings
  alias Anais.Proceedings.Article

  action_fallback AnaisWeb.FallbackController

  def index(conn, _params) do
    articles = Proceedings.list_articles()
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params}) do
    with {:ok, %Article{} = article} <- Proceedings.create_article(article_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.article_path(conn, :show, article))
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Proceedings.get_article!(id)
    render(conn, "show.json", article: article)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Proceedings.get_article!(id)

    with {:ok, %Article{} = article} <- Proceedings.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end
end
