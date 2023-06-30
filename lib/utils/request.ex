defmodule Iniciador.Utils.Request do
  alias Iniciador.Utils.Config
  alias Iniciador.{Error, AccessToken}

  @spec request(any, binary, any) :: {:ok, map} | {:error, Error.t()}
  def request(method, path, options \\ []) do
    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)

    %{payload: payload, access_token: access_token, query_params: query_params} =
      Enum.into(options, %{payload: nil, access_token: nil, query_params: nil})

    {:ok, {{'HTTP/1.1', status_code, _status_message}, _headers, response_body}} =
      :httpc.request(
        method,
        get_request_parameters(path, query_params, access_token, payload),
        [],
        []
      )

    process_response(method, path, {status_code, response_body})
  end

  defp get_headers(nil),
    do: [
      {'Content-Type', 'application/json'},
      {'User-Agent', 'Elixir-#{System.version()}-SDK-0.0.1'}
    ]

  defp get_headers(%AccessToken{access_token: access_token}),
    do: Enum.concat(get_headers(nil), [{'Authorization', "Bearer #{access_token}"}])

  defp get_request_parameters(path, query_params, access_token, nil),
    do: {build_url(path, query_params), get_headers(access_token)}

  defp get_request_parameters(path, query_params, access_token, payload),
    do:
      {build_url(path, query_params), get_headers(access_token), 'application/json',
       get_encoded_body!(payload)}

  defp build_url(path, nil), do: (Config.get_url() <> path) |> String.to_charlist()

  defp build_url(path, query_params) do
    (Config.get_url() <> path)
    |> URI.new!()
    |> URI.append_query(URI.encode_query(query_params))
    |> URI.to_string()
    |> String.to_charlist()
  end

  defp get_encoded_body!(value), do: Jason.encode!(value)

  defp process_response(method, path, {status_code, body}) do
    cond do
      status_code >= 400 ->
        {:error, build_error(path, method, body)}

      true ->
        {:ok, body |> Jason.decode!() |> underscore_keys()}
    end
  end

  defp build_error(path, method, response_body) do
    case Jason.decode(response_body) do
      {:ok,
       %{
         "message" => message,
         "statusCode" => status_code,
         "method" => method,
         "path" => path,
         "timestamp" => timestamp
       }} ->
        %Error{
          status_code: status_code,
          message: message,
          method: method,
          path: path,
          timestamp: timestamp
        }

      _ ->
        %Error{
          status_code: nil,
          message: ["Unknown error encountered: " <> to_string(response_body)],
          method: Atom.to_string(method) |> String.upcase(),
          path: path,
          timestamp: DateTime.utc_now() |> DateTime.to_iso8601()
        }
    end
  end

  defp underscore_keys(data) when is_map(data) do
    Enum.reduce(data, %{}, fn {key, value}, acc ->
      new_key = key |> Macro.underscore() |> String.to_atom()
      new_value = underscore_keys(value)
      Map.put(acc, new_key, new_value)
    end)
  end

  defp underscore_keys(data) when is_list(data) do
    Enum.map(data, &underscore_keys/1)
  end

  defp underscore_keys(data), do: data
end
