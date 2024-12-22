import Config

if Mix.env() == :dev do
  config :git_ops,
    mix_project: AshCqrs.MixProject,
    changelog_file: "CHANGELOG.md",
    repository_url: "https://github.com/accountextorg/ash_cqrs",
    # Instructs the tool to manage your mix version in your `mix.exs` file
    # See below for more information
    manage_mix_version?: true,
    # Instructs the tool to manage the version in your README.md
    # Pass in `true` to use `"README.md"` or a string to customize
    manage_readme_version: [
      "README.md",
      "documentation/tutorials/get-started-with-ash-cqrs.md"
    ],
    version_tag_prefix: "v"
end


if Mix.env() == :test do

  # Write resource test configuration
  config :ash_postgres, AshCqrs.WriteTestRepo, log: false
  config :ash_postgres, AshCqrs.WriteTestRepo,
    username: "postgres",
    database: "ash_cqrs_write_test",
    hostname: "localhost",
    pool: Ecto.Adapters.SQL.Sandbox
    # sobelow_skip ["Config.Secrets"]
  config :ash_postgres, AshCqrs.WriteTestRepo, password: "postgres"
  config :ash_postgres, AshCqrs.WriteTestRepo, migration_primary_key: [name: :id, type: :binary_id]

  # Read resource test configuration
  config :ash_postgres, AshCqrs.ReadTestRepo, log: false
  config :ash_postgres, AshCqrs.ReadTestRepo,
    username: "postgres",
    database: "ash_cqrs_read_test",
    hostname: "localhost",
    pool: Ecto.Adapters.SQL.Sandbox
    # sobelow_skip ["Config.Secrets"]
  config :ash_postgres, AshCqrs.ReadTestRepo, password: "postgres"
  config :ash_postgres, AshCqrs.ReadTestRepo, migration_primary_key: [name: :id, type: :binary_id]

  # Ash configuration
  config :ash, :validate_domain_resource_inclusion?, false
  config :ash, :validate_domain_config_inclusion?, false
  config :ash, :policies, show_policy_breakdowns?: true
  config :ash, :custom_expressions, [AshPostgres.Expressions.TrigramWordSimilarity]

  # AshPostgres configuration
  config :ash_postgres,
    ecto_repos: [AshCqrs.WriteTestRepo, AshCqrs.ReadTestRepo],
    ash_domains: [AshPostgres.Test.Domain]

  config :ash, :compatible_foreign_key_types, [
    {Ash.Type.String, Ash.Type.UUID}
  ]

  config :logger, level: :warning
end
