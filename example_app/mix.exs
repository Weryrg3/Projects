defmodule ExampleApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :example_app,
      version: "0.1.0",
      elixir: "~> 1.6-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ecto, :postgrex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
     {:ecto, "~> 2.1.6"},
     {:postgrex, ">=0.13.5"}
    ]
  end
end
