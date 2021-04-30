defmodule Anais.Repo do
  use Ecto.Repo,
    otp_app: :anais,
    adapter: Ecto.Adapters.Postgres
end
