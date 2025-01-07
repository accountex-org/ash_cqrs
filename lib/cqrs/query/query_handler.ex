defmodule AshCqrs.QueryHandler do
  @moduledoc """
  A DSL section for creating query handlers.
  See the getting started guide for more.
  """

  @query_handler_schema %Spark.Dsl.Section{
    name: :query_handler,
    schema: [
      handle_with: [
        type: {:one_of, [
            Ash.Resource.Actions.Action,
            Ash.Reactor
          ]},
        doc: """
        Either an `Ash.Resource.Actions.Action` for simple processing or an
        `Ash.Reactor` for more complex business logic handling.
        """
      ],
      arguments: [
        type: list({:spark, AshCqrs.QueryArgument}),
        doc: """
        The arguments for the query handler.
        """,
        required: false
      ]
    ]
  }

  # Defines the entity constructor for a query handler.
  @query_handler %Spark.Dsl.Entity{
    name: :query_handler,
    describe: """
    Declares a new query handler that will be used to handle an incoming `AshCqrs.Query``.
    """,
    examples: [],
    target: AshCqrs.QueryHandler,
    args: [:handle_with, :arguments],
    schema: @query_handler_schema
  }

  # Declares the query handlers section
  @query_handlers %Spark.Dsl.Section{
    name: :query_handlers,
    describe: """
    Configures query handlers that will be used to handle incoming `AshCqrs.Query`s.

    ## Example

    ```elixir
    query_handlers do
      query_handler
        name: :handle_get_user_by_id do,
        handle_with: MyApp.Users.GetUserById,
        arguments: [
          id: :id
        ]
      end
    ```
    """,
    entities: [@query_handler],
  }


  @sections [@query_handlers]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
