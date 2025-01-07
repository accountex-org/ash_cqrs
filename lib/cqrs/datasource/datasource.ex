defmodule AshCqrs.DataSource do
  @moduledoc """
  An extension for declaring a data source.

  A DataSource represents the duality of ressources in the CQRS pattern.
  Both a writable for commands `Ash.Domain` and a read-only one for queries must be declared.
  Each domain can have the same `Ash.DataLayer` but is not required.

  It is totally valid to have an `Ash.PostGres` data layer as an example and a read-only NoSql data-layer.

  See the getting started guide for more.
  """

  # Defines the entity constructor for an ash domain to write to.
  @write_to_domain %Spark.Dsl.Entity{
    name: :write_to_domain,
    describe: """
    Adds a new `AshCqrs.WriteToDomain` to the datasource.
    """,
    examples: [],
    target: AshCqrs.WriteToDomain,
    schema: AshCqrs.WriteToDomain.schema(),
    args: [:ash_domain]
  }

  # Defines the entity constructor for an ash domain to read from.
  @read_from_domain %Spark.Dsl.Entity{
    name: :read_from_domain,
    describe: """
    Adds a new `AshCqrs.ReadFromDomain` to the datasource.
    """,
    examples: [],
    target: AshCqrs.ReadFromDomain,
    schema: AshCqrs.ReadFromDomain.schema(),
    args: [:ash_domain]
  }

  @datasource %Spark.Dsl.Section{
    name: :datasource,
    describe: """
    A section for configuring the domains to use throughout the CQRS pattern.

    - A datasource must contain a single `AshCqrs.WriteToDomain`.
    - A datasource must contain a single `AshCqrs.ReadFromDomain` as well.

    """,
    examples: [
      """
      datasource do
        write_to_domain MyApp.Domain1
        read_from_domain: MyApp.Domain2
      end
      """
    ],
    entities: [
      @write_to_domain,
      @read_from_domain
    ]
  }



  @sections [@datasource]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
