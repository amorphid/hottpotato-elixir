defmodule HoTTPotato.MixProject do
  use Mix.Project

  def project do
    [
      app: :hottpotato,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HoTTPotato.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # static analysis
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      # doc generation
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end
end
