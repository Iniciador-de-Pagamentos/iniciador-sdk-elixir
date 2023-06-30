defmodule Iniciador.Error do
  @doc """
  Error generated on interactions with Iniciador

  ## Attributes:
    - `status_code` [pos_integer]: defines de error status code
    - `message` [list(string)]: error messages
    - `path` [string]: path of the request
    - `method` [string]: method of the request
    - `timestamp` [string]: timestamp of the request
  """

  defstruct [:status_code, :message, :method, :path, :timestamp]

  @type t :: %__MODULE__{}
end
