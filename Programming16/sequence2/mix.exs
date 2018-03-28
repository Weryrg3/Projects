defmodule Sequence2.MixProject do
  use Mix.Project

  def project do
    [
      app: :sequence2,
      version: "0.3.0",
      elixir: "~> 1.6-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {MainApplication, 500},
      # env: [initial_number: 456],
      registered: [Sequence2.Server],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:distillery, "~> 1.5.2", runtime: false}
    ]
  end
end

