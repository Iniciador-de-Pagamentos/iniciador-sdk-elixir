defmodule Iniciador.Utils.JWT do
  def get_payload!(jwt_token) do
    [_, payload_base64, _] = String.split(jwt_token, ".")

    case Base.decode64!(payload_base64, padding: false) |> Jason.decode!() do
      %{"payload" => payload} -> payload
      _ -> raise "Invalid JWT token"
    end
  end
end
