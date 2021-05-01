defmodule Anais.EventFactory do
  defmacro __using__(_opts) do
    quote do
      def event_factory do
        %Anais.Proceedings.Event{
          title: Faker.Lorem.word,
          description: Faker.Lorem.paragraph(1)
        }
      end
    end
  end
end
