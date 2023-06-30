defmodule Iniciador.Utils.Config do
  @type env :: :dev | :stag | :sandbox | :prod

  @spec env :: env()
  def env do
    case Application.fetch_env(:iniciador, :env) do
      {:ok, env} when env in [:dev, :stag, :sandbox, :prod] -> env
      _ -> raise "please set an valid environment (:dev, :stag or :prod)"
    end
  end

  def client_id do
    case Application.fetch_env(:iniciador, :client_id) do
      {:ok, client_id} -> client_id
      _ -> raise "please set an valid client_id"
    end
  end

  def client_secret do
    case Application.fetch_env(:iniciador, :client_secret) do
      {:ok, client_secret} -> client_secret
      _ -> raise "please set an valid client_secret"
    end
  end

  @spec get_url :: binary()
  def get_url do
    case env() do
      :dev -> "https://consumer.dev.inic.dev/v1"
      :stag -> "https://consumer.staging.inic.dev/v1"
      :sandbox -> "https://consumer.sandbox.inic.dev/v1"
      :prod -> "https://consumer.u4c-iniciador.com.br/v1"
    end
  end
end
