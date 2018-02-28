defmodule Conditions.MixProject do
  use Mix.Project

  def project do
    [
      app: :conditions,
      version: "0.1.0",
      elixir: "~> 1.6-rc",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: Coverex.Task],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # { :hackney, github: "benoitc/hackney" },
      {:httpoison, "~> 0.13.0"},
      {:poison, "~> 3.1"},
      {:credo, "~> 0.9.0-rc7", only: [:dev, :test], runtime: false},
      {:coverex, "~> 1.4.10", only: :test}
    ]
  end
end
