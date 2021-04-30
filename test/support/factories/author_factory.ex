defmodule Anais.AuthorFactory do
  defmacro __using__(_opts) do
    quote do
      def author_factory do
        %Anais.Account.Author{
          email: "login-#{Faker.Lorem.word()}.#{Faker.random_between(0, 100)}",
          password: "$2b$12$iWNYYuxNcQhaUuJ82jLKu..jbrQQl8..it6K5AvdVovOwDmLX2OVu",
          name: "nick-#{Faker.Lorem.word()}.#{Faker.random_between(0, 100)}"
        }
      end
    end
  end
end
