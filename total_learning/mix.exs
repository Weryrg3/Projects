defmodule TotalLearning.MixProject do
  use Mix.Project

  def project do
    [
      app: :total_learning,
      version: "0.1.0",
      elixir: "~> 1.6-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: Coverex.Task],
      dialyzer: [
        plt_add_deps: :apps_direct,
        plt_add_apps: [:wx],
        ignore_warnings: ".dialyzer-warnings"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 0.5.1", only: [:dev], runtime: false},
      {:credo, "~> 0.9.0-rc7", only: [:dev, :test], runtime: false},
      {:coverex, "~> 1.4.15", only: :test},
      {:httpoison, "~> 1.0.0"},
      {:poison, "~> 3.1.0"}
    ]
  end
end
