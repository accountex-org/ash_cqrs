defmodule AshCqrs.CommandHandler do
  @moduledoc """
  A DSL section for creating command handlers.
   See the getting started guide for more.
  """

  @command_handler_schema %Spark.Dsl.Section{
    name: :command_handler,
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
        type: list({:spark, AshCqrs.CommandArgument}),
        doc: """
        The arguments for the command handler.
        """,
        required: false
      ]
    ]
  }

  # Defines the entity constructor for a command handler.
  @command_handler %Spark.Dsl.Entity{
    name: :command_handler,
    describe: """
    Declares a new command handler that will be used to handle an incoming `AshCqrs.Command``.
    """,
    examples: [],
    target: AshCqrs.CommandHandler,
    args: [:handle_with, :arguments],
    schema: @command_handler_schema
  }

  # Declares the command handlers section
  @command_handlers %Spark.Dsl.Section{
    name: :command_handlers,
    describe: """
    Configures command handlers that will be used to handle incoming `AshCqrs.Command`s.

    ## Example

    ```elixir
    command_handlers do
      command_handler
        name: :handle_create_user do,
        handle_with: MyApp.Users.Create,
        arguments: [
          user: :user
        ]
      end
    ```
    """,
    entities: [@command_handler],
  }


  @sections [@command_handlers]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
