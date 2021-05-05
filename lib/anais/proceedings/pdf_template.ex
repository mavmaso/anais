defmodule Anais.HtmlTemplate do
  use Temple

  def event_to_html(event, articles) do
    temple do
      h1 do b event.title end

      for a <- articles do
        h2 a.title
        p a.abstract
      end
    end
  end
end
