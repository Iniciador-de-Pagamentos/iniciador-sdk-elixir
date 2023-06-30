defmodule Iniciador.Auth do
  alias Iniciador.Utils.{Request, Config, JWT}
  alias Iniciador.{Error, AccessToken}

  @doc """
  Handles the authentication process by making request to the auth endpoint.

  ## Return:
    - `access_token` - The access token to be used in the other requests.
  """
  @spec auth :: {:ok, AccessToken.t()} | {:error, Error.t()}
  def auth do
    case Request.request(:post, "/auth",
           payload: %{clientId: Config.client_id(), clientSecret: Config.client_secret()}
         ) do
      {:ok, response} ->
        {:ok,
         %AccessToken{
           access_token: response.access_token,
           payment_id: JWT.get_payload!(response.access_token)["id"]
         }}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Handles the authentication process for whitelabels by making request to the auth/interfac endpoint.

  ## Params:
    - `payment` - The payment map to be used in the request.

  ## Return:
    - `access_token` - The access token to be used in the other requests.
    - `payment_id` - The payment id to be used in the other requests.
    - `interface_url` - The interface url to be used in the other requests.
  """
  @spec auth_interface(payment :: map) ::
          {:ok, AccessToken.t()}
          | {:error, Error.t()}
  def auth_interface(payment) do
    case Request.request(:post, "/auth/interface",
           payload: %{
             clientId: Config.client_id(),
             clientSecret: Config.client_secret(),
             payment: payment
           }
         ) do
      {:ok, response} ->
        {:ok, struct(AccessToken, response)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Reconstructs an AccessToken from the payment initiation JWT

  ## Params:
    - `token` - The JWT token to be used in the request.

  ## Return:
    - `access_token` - The access token to be used in the other requests.
    - `payment_id` - The payment id to be used in the other requests.
    - `interface_url` - The interface url to be used in the other requests.
  """
  @spec build_access_token(token :: binary()) :: AccessToken.t()
  def build_access_token(token) do
    %AccessToken{
      access_token: token,
      payment_id: JWT.get_payload!(token)["id"]
    }
  end
end
