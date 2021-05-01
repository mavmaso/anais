defmodule Anais.Factory do
  use ExMachina.Ecto, repo: Anais.Repo

  use Anais.AuthorFactory
  use Anais.EventFactory
  use Anais.ArticleFactory
end
