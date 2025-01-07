defmodule AshCqrs.Queries.Query do
  @moduledoc """
  An extension for defining a query to be processed by the CQRS system.

  """

  # Defines the options schema for the query.
  @query_schema [
    name: [
      type: :atom,
      doc: "A unique atom identifying the name of the query.",
      required: true
    ],
    description: [
      type: :string,
      doc: "An optional description for the query.",
      required: false
    ],
    handler: [
      type: {:one_of, [
          Ash.Resource.Actions.Action,
          Ash.Reactor
        ]},
      doc: """
      Either an `Ash.Resource.Actions.Action` for simple querying or an
      `Ash.Reactor` for more complex query handling.
      """
    ],
    args: [
      type: {:list, {:spark, Ash.Resource.Actions.Argument}},
      doc: """
      The arguments for the query execution.
      """,
      required: false
    ]
  ]

  # Defines the entity constructor for a query.
  @query %Spark.Dsl.Entity{
    name: :query,
    describe: """
    Defines a new query and its handler.
    """,
    examples: [],
    target: AshCqrs.Queries.Query,
    args: [:name, :description, :handler, :args],
    schema: @query_schema
  }

  # Declares the queries section
  @queries %Spark.Dsl.Section{
    name: :queries,
    describe: """
    Configures what queries will be available in the system.

    Queries are used for effectful changes to the system.
    They usually involve some sort of persistence of the data but not necessarily.

    ## Example

    ```elixir
    queries do
      query do
        name: :create_post,
        description: "Creates a new post.",
        handler: CreatePostAction,
        args: [
          post: :post_argument
        ]
      end
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
