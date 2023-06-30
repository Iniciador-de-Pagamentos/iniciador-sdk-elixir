defmodule Iniciador.Participants do
  alias Iniciador.Utils.Request
  alias Iniciador.{AccessToken, Error}

  @typedoc """
  Represents the parameters for listing participants.

  ## Fields
  - `id` (`binary() | nil`) - Optional. The ID of the participant.
  - `name` (`binary() | nil`) - Optional. The name of the participant.
  - `slug` (`binary() | nil`) - Optional. The slug of the participant.
  - `status` (`binary() | nil`) - Optional. The status of the participant, it can be "ACTIVE" or "INACTIVE"
  - `first_participants` (`binary() | nil`) - Optional. The first participants splitted by comma.
  - `limit` (`binary() | nil`) - Optional. The limit for the number of participants.
  - `after_cursor` (`binary() | nil`) - Optional. The cursor for pagination, representing the position to start listing after.
  - `before_cursor` (`binary() | nil`) - Optional. The cursor for pagination, representing the position to start listing before.
  """

  @type list_params :: %{
          id: binary() | nil,
          name: binary() | nil,
          slug: binary() | nil,
          status: binary() | nil,
          first_participants: binary() | nil,
          limit: binary() | nil,
          after_cursor: binary() | nil,
          before_cursor: binary() | nil
        }

  @doc """
  Lists participants using the provided access token and parameters.

  ## Parameters
  - `access_token` (`AccessToken.t()`) - The access token used for authentication.
  - `params` (`map()`) - Optional. The parameters for listing participants. Default is an empty map.

  ## Returns
  - `{:ok, map()}` - The participants are successfully listed.
  - `{:error, Error.t()}` - An error occurred during the listing process.

  ## Example
  ```elixir
  {:ok, participants} = list(access_token, %{limit: 10})
  ```
  """
  @spec list(access_token :: AccessToken.t(), params :: list_params) ::
          {:ok, map()} | {:error, Error.t()}
  def list(%AccessToken{} = access_token, params) do
    query_params =
      (params || %{})
      |> Map.new(fn {k, v} ->
        {camelize(k), v}
      end)

    case Request.request(:get, "/participants",
           access_token: access_token,
           query_params: query_params
         ) do
      {:ok, response} ->
        {:ok, response}

      {:error, error} ->
        {:error, error}
    end
  end

  defp camelize(key) do
    camelcased = key |> Atom.to_string() |> Macro.camelize()

    (camelcased |> String.slice(0..0) |> String.downcase()) <> String.slice(camelcased, 1..-1)
  end
end
