defmodule AshCqrs.Command do
  @moduledoc """
  An extension for creating a command. See the getting started guide for more.
  """

  # Defines the options schema for the command.
  @command_schema [
    command_name: [
      type: :atom,
      doc: "A unique atom identifying the name of the command.",
      required: true
    ],
    pre_check_identities_with: [
      type: {:spark, Ash.Domain},
      doc: "A domain to use to precheck generated identities. Required by certain data layers.",
      required: false
    ],
    command_handler: [
      type: {:spark, AshCqrs.CommandHandler},
      doc: "The handler for the command execution.",
      required: true
    ]
  ]

  # Defines the entity constructor for a command.
  @command %Spark.Dsl.Entity{
    name: :command,
    describe: """
    Declares a new command.
    """,
    examples: [],
    target: AshCqrs.Command,
    args: [:command_name, :pre_check_identities_with, :command_handler],
    schema: @command_schema
  }

  # Declares the commands section
  @commands %Spark.Dsl.Section{
    name: :commands,
    describe: """
    Configures what commands will be avaliable.

    Commands are used for effectful changes to the system.
    They usually involve some sort of persistence of the data but not necessarily.

    ## Example

    ```elixir
    commands do
      command :create_user do,
        command_handler: CreateUserHandler
      end
    ```
    """,
    entities: [@command],
  }


  @sections [@commands]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
