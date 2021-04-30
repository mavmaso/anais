defmodule Anais.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :Anais,
  module: Anais.Guardian,
  error_handler: Anais.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
