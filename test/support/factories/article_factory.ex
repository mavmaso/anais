defmodule Anais.ArticleFactory do
  defmacro __using__(_opts) do
    quote do
      def article_factory do
        %Anais.Proceedings.Article{
          title: Faker.Lorem.word,
          abstract: Faker.Lorem.paragraph(1),
          event: build(:event),
          author: build(:author)
        }
      end
    end
  end
end
