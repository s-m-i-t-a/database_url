defmodule DatabaseUrl.Mixfile do
  use Mix.Project

  def project do
    [app: :database_url,
     version: "0.1.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     test_coverage: [tool: ExCoveralls],
     description: "Parse database URL and renturn keyword list for use with Ecto.",
     package: package,
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: []]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:excoveralls, "~> 0.3", only: [:dev, :test]}]
  end

  defp package do
    [
      files:        ["lib", "mix.exs", "README*", "LICENSE*"],
      contributors: ["Jindrich K. Smitka <smitka.j@gmail.com>"],
      licenses:     ["BSD"],
      links:        %{
        "GitHub" => "https://github.com/s-m-i-t-a/database_url",
      }
    ]
  end
end
