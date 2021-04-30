defmodule AnaisWeb.AuthorController do
  use AnaisWeb, :controller

  alias Anais.Account
  alias Anais.Account.Author

  action_fallback AnaisWeb.FallbackController

  def index(conn, _params) do
    authors = Account.list_authors()
    render(conn, "index.json", authors: authors)
  end

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- Account.create_author(author_params) do
      conn
      |> put_status(:created)
      |> render("show.json", author: author)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Account.get_author!(id)
    render(conn, "show.json", author: author)
  end

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, token, _claims} <- Account.token_sign_in(email, password) do
      conn |> json(%{data: %{jwt: token}})
    else
      _ -> {:error, :unauthorized}
    end
  end
end
