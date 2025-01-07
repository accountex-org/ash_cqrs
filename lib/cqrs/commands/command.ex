defmodule AshCqrs.Commands.Command do
  @moduledoc """
  An extension for defining a command to be processed by the CQRS system.

  """

  # Defines the options schema for the command.
  @command_schema [
    name: [
      type: :atom,
      doc: "A unique atom identifying the name of the command.",
      required: true
    ],
    description: [
      type: :string,
      doc: "An optional description for the command.",
      required: false
    ],
    handler: [
      type: {:one_of, [Ash.Resource.Actions.Action, Ash.Reactor]},
      doc: """
      Either a simple `Ash.Resource.Actions.Action` or an `Ash.Reactor` for more complex logic handling.
      """
    ],
    args: [
      type: {:list, {:spark, Ash.Resource.Actions.Argument}},
      doc: """
      The arguments for the command execution.
      """,
      required: false
    ]
  ]

  # Defines the entity constructor for a command.
  @command %Spark.Dsl.Entity{
    name: :command,
    describe: """
    Defines a new command and its handler.
    """,
    examples: [],
    target: AshCqrs.Commands.Command,
    args: [:name, :description, :handler, :args],
    schema: @command_schema
  }

  # Declares the commands section
  @commands %Spark.Dsl.Section{
    name: :commands,
    describe: """
    Configures what commands will be available in the system.

    Commands are used for effectful changes to the system.
    They usually involve some sort of persistence of the data but not necessarily.

    ## Example

    ```elixir
    commands do
      command do
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
    entities: [@command],
  }


  @sections [@commands]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
