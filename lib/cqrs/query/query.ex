defmodule AshCqrs.Query do
  @moduledoc """
  An extension for creating a query in the context of the CQRS system.

  See the getting started guide for more.
  """
  use Spark.Dsl.Fragment, of: AshCqrs

  # Defines the options schema for the query.
  @query_schema [
    query_name: [
      type: :atom,
      doc: "A unique atom identifying the name of the query.",
      required: true
    ],
    query_handler: [
      type: {:spark, AshCqrs.QueryHandler},
      doc: "The handler for the query execution.",
      required: true
    ]
  ]

  # Defines the entity constructor for a query.
  @query %Spark.Dsl.Entity{
    name: :query,
    describe: """
    Declares a new query.
    """,
    examples: [],
    target: AshCqrs.Query,
    args: [:query_name, :query_handler],
    schema: @query_schema
  }

  # Declares the queries section
  @queries %Spark.Dsl.Section{
    name: :queries,
    describe: """
    Configures what queries will be available in the system.

    Queries are used for inquiring eventually consistent data.
    The queryable data is made consistent by processing the events queue.
    This is the task of the events processor to keep both side in sync.

    ## Example

    ```elixir
    queries do
      query :get_user do,
        query_handler: GetUserHandler
      end
    ```
    """,
    entities: [@query],
  }


  @sections [@queries]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
