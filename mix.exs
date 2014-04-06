defmodule ElixirShrtnr.Mixfile do
  use Mix.Project

  def project do
    [ app: :elixirShrtnr,
      version: "0.0.1",
      build_per_environment: true,
      dynamos: [ElixirShrtnr.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { ElixirShrtnr, [] } ]
  end

  defp deps do
    [ { :cowboy, github: "extend/cowboy" },
      { :dynamo, "~> 0.1.0-dev", github: "elixir-lang/dynamo" },
      { :redis, "1.1.0", [ github: "timbuchwaldt/elixir-redis"]}
    ]
  end
end
