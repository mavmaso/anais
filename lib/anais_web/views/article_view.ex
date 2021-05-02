defmodule AnaisWeb.ArticleView do
  use AnaisWeb, :view

  alias Anais.Proceedings
  alias AnaisWeb.ArticleView

  def render("index.json", %{articles: articles}) do
    %{data: render_many(articles, ArticleView, "article.json")}
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, ArticleView, "article.json")}
  end

  def render("article.json", %{article: article}) do
    article = Proceedings.preload_article(article)

    %{
      id: article.id,
      title: article.title,
      abstract: article.abstract,
      author: %{
        id: article.author.id,
        name: article.author.name
      },
      event: %{
        id: article.event.id,
        title: article.event.title,
        description: article.event.description
      }
    }
  end
end
