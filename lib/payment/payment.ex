defmodule Iniciador.Payment do
  alias Iniciador.Utils.Request
  alias Iniciador.{AccessToken, Error}
  alias Iniciador.Payment.{PaymentInitiation, PaymentInitiationStatus}

  @doc """
  Retrieves payment information using the provided access token.

  ## Parameters
  - `access_token` (`AccessToken.t()`) - The access token used for authentication.

  ## Returns
  - `{:ok, PaymentInitiation.t()}` - The payment information is successfully retrieved.
  - `{:error, Error.t()}` - An error occurred during the retrieval process.

  ## Example
  ```elixir
  {:ok, payment_info} = get(access_token)
  ```
  """

  @spec get(AccessToken.t()) :: {:ok, PaymentInitiation.t()} | {:error, Error.t()}
  def get(%AccessToken{payment_id: payment_id} = access_token) do
    case Request.request(:get, "/payments/#{payment_id}", access_token: access_token) do
      {:ok, response} ->
        {:ok, struct(PaymentInitiation, response)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Retrieves the status of a payment using the provided access token.

  ## Parameters
  - `access_token` (`AccessToken.t()`) - The access token used for authentication.

  ## Returns
  - `{:ok, PaymentInitiationStatus.t()}` - The payment status is successfully retrieved.
  - `{:error, Error.t()}` - An error occurred during the retrieval process.

  ## Example
  ```elixir
  {:ok, payment_status} = status(access_token)
  ```
  """
  @spec status(AccessToken.t()) :: {:ok, PaymentInitiationStatus.t()} | {:error, Error.t()}
  def status(%AccessToken{payment_id: payment_id} = access_token) do
    case Request.request(:get, "/payments/#{payment_id}/status", access_token: access_token) do
      {:ok, response} ->
        {:ok, struct(PaymentInitiationStatus, response)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Retrieves the interface URL associated with a payment using the provided access token.

  ## Parameters
  - `access_token` (`AccessToken.t()`) - The access token used for data retrieval.

  ## Returns
  - `{:ok, binary()}` - The interface URL is successfully retrieved.
  - `{:error, Error.t()}` - An error occurred during the retrieval process or the interface URL is not found.

  ## Example
  ```elixir
  {:ok, interface_url} = get_interface_url(access_token)
  ```
  """
  @spec get_interface_url(AccessToken.t()) :: {:ok, binary()} | {:error, Error.t()}
  def get_interface_url(%AccessToken{interface_url: nil}),
    do:
      {:error,
       "Interface URL not found for this payment. Make sure it was created with auth_interface!"}

  def get_interface_url(%AccessToken{interface_url: interface_url}), do: {:ok, interface_url}

  @doc """
  Enqueue a payment request using the provided access token and payment details.

  ## Parameters
  - `access_token` (`Iniciador.AccessToken.t()`) - The access token used for authentication.
  - `payment` (`map()`) - The details of the payment request.

  ## Returns
  - `{:ok, PaymentInitiation.t()}` - The payment request is successfully sent.
  - `{:error, Iniciador.Error.t()}` - An error occurred during the sending process.

  ## Example
  ```elixir
  {:ok, response} = send(access_token, %{amount: 100, currency: "USD"})
  ```
  """
  @spec send(access_token :: Iniciador.AccessToken.t(), payment :: map()) ::
          {:ok, map} | {:error, Iniciador.Error.t()}
  def send(%AccessToken{} = access_token, payment) do
    case Request.request(:post, "/payments", access_token: access_token, payload: payment) do
      {:ok, response} ->
        {:ok, response}

      {:error, error} ->
        {:error, error}
    end
  end
end
