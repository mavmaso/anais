defmodule AnaisWeb.SessionController do
  use AnaisWeb, :controller

  alias Anais.Account

  action_fallback AnaisWeb.FallbackController

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, token, _claims} <- Account.token_sign_in(email, password) do
      conn |> json(%{data: %{jwt: token}})
    else
      _ -> {:error, :unauthorized}
    end
  end
end
