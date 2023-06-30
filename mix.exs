defmodule Iniciador.MixProject do
  use Mix.Project

  def project do
    [
      app: :iniciador,
      name: :iniciador,
      version: "0.0.1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package(),
      docs: docs(),
      homepage_url: "https://iniciador.com.br/",
      source_url: "https://github.com/Iniciador-de-Pagamentos/iniciador-sdk-elixir"
    ]
  end

  defp package do
    [
      maintainers: ["Iniciador"],
      licenses: [:MIT],
      links: %{
        "Iniciador" => "https://iniciador.com.br/",
        "GitHub" => "https://github.com/Iniciador-de-Pagamentos/iniciador-sdk-elixir"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets]
    ]
  end

  defp description do
    "SDK to integrate with Iniciador"
  end

  defp docs do
    [
      main: "Iniciador",
      extras: ["README.md"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
