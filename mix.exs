defmodule AshCqrs.MixProject do
  use Mix.Project

  @version "0.0.1"
  @description """
  An implementation of the CQRS pattern for the Ash framework.
  """

  # Project information
  def project do
    [
      app: :ash_cqrs,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :test,
      description: @description,
      aliases: aliases(),
      deps: deps(),
      package: package(),
      docs: docs(),
      source_url: "https://github.com/acountex-org/ash_cqrs",
      homepage_url: "https://github.com/acountex-org/ash_cqrs",
      consolidate_protocols: Mix.env() != :test
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Package definition
  defp package do
    [
      name: :ash_cqrs,
      licenses: ["MIT"],
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*
        CHANGELOG* documentation),
      links: %{
        GitHub: "https://github.com/accountex-org/ash_cqrs"
      }
    ]
  end

  # Mix aliases
  defp aliases do
    [
      sobelow: "sobelow --skip",
      credo: "credo --strict",
      docs: [
        "spark.cheat_sheets",
        "docs",
        "spark.replace_doc_links",
        "spark.cheat_sheets_in_search"
      ],
      "spark.formatter": "spark.formatter --extensions AshCqrs",
      "spark.cheat_sheets":
        "spark.cheat_sheets --extensions AshCqrs.Commands.Command,AshCqrs.Queries.Query,AshCqrs.Events.Event",
      "spark.cheat_sheets_in_search":
        "spark.cheat_sheets_in_search --extensions AshCqrs.Commands.Command,AshCqrs.Queries.Query,AshCqrs.Events.Event"
    ]
  end

  # Package Documentation
  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      logo: "logos/small-logo.png",
      before_closing_head_tag: fn type ->
        if type == :html do
          """
          <script>
            if (location.hostname === "hexdocs.pm") {
              var script = document.createElement("script");
              script.src = "https://plausible.io/js/script.js";
              script.setAttribute("defer", "defer")
              script.setAttribute("data-domain", "ashhexdocs")
              document.head.appendChild(script);
            }
          </script>
          """
        end
      end,
      extras: [
        {"README.md", title: "Home"},
        "CHANGELOG.md"
      ],
      groups_for_extras: [
        Tutorials: ~r'documentation/tutorials',
        "How To": ~r'documentation/how_to',
        Topics: ~r'documentation/topics',
        DSLs: ~r'documentation/dsls',
        "About AshCqrs": [
          "CHANGELOG.md"
        ]
      ],
      groups_for_modules: [
        Introspection: [
          AshCqrs.Commands.Info,
          AshCqrs.Events.Info,
          AshCqrs.Queries.Info
        ],
        Entities: [
          AshCqrs.Commands.Commmand,
          AshCqrs.Events.Commmand,
          AshCqrs.Queries.Commmand
        ],
        Types: [],
        AshCqrs: ~r/AshCqrs.*/
      ]
    ]
  end

  # Project dependencies.
  defp deps do
    [
      {:ash, ash_version("~> 3.0")},
      {:reactor, "~> 0.10.3"},
      # dev/test dependencies
      {:git_ops, "~> 2.5", only: [:dev, :test]},
      {:ex_doc, github: "elixir-lang/ex_doc", only: [:dev, :test], runtime: false},
      {:ex_check, "~> 0.14", only: [:dev, :test]},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:sobelow, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:mix_audit, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:wallaby, "~> 0.30.9", only: [:test], runtime: false}
    ]
  end

  defp ash_version(default_version) do
    case System.get_env("ASH_VERSION") do
      nil ->
        default_version

      "local" ->
        [path: "../ashcqrs", override: true]

      "main" ->
        [git: "https://github.com/accountex-org/ashcqrs.git", override: true]

      version when is_binary(version) ->
        "~> #{version}"

      version ->
        version
    end
  end
end
