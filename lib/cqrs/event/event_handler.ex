defmodule AshCqrs.EventHandler do
  @moduledoc """
  A DSL section for creating event handlers.
  See the getting started guide for more.
  """
  @event_handler_schema %Spark.Dsl.Section{
    name: :event_handler,
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
        type: list({:spark, AshCqrs.EventArgument}),
        doc: """
        The arguments for the event handler.
        """,
        required: false
      ]
    ]
  }

  # Defines the entity constructor for a event handler.
  @event_handler %Spark.Dsl.Entity{
    name: :event_handler,
    describe: """
    Declares a new event handler that will be used to handle an incoming `AshCqrs.Event``.
    """,
    examples: [],
    target: AshCqrs.EventHandler,
    args: [:handle_with, :arguments],
    schema: @event_handler_schema
  }

  # Declares the event handlers section
  @event_handlers %Spark.Dsl.Section{
    name: :event_handlers,
    describe: """
    Configures event handlers that will be used to handle incoming `AshCqrs.Event`s.

    ## Example

    ```elixir
    event_handlers do
      event_handler
        name: :handle_create_user do,
        handle_with: MyApp.Users.Create,
        arguments: [
          user: :user
        ]
      end
    ```
    """,
    entities: [@event_handler],
  }


  @sections [@event_handlers]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
