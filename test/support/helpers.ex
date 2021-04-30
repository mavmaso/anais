defmodule Anais.Helpers do
  import Plug.Conn

  def login(conn, user) do
    {:ok, jwt, _claims} = Anais.Guardian.encode_and_sign(user)

    conn =
      conn
      |> put_req_header("authorization", "Bearer #{jwt}")

    conn
  end
end
