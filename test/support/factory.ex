defmodule Anais.Factory do
  use ExMachina.Ecto, repo: Anais.Repo

  use Anais.AuthorFactory
end
