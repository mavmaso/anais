defmodule Anais.AuthorFactory do
  defmacro __using__(_opts) do
    quote do
      def author_factory do
        %Anais.Account.Author{
          email: "#{Faker.Internet.free_email()}.#{:rand.uniform(100)}",
          password: "$2b$12$iWNYYuxNcQhaUuJ82jLKu..jbrQQl8..it6K5AvdVovOwDmLX2OVu",
          name: Faker.Person.PtBr.name()
        }
      end
    end
  end
end
