defmodule Iniciador.AccessToken do
  defstruct [:access_token, :payment_id, :interface_url]

  @type t :: %__MODULE__{}
end
