defmodule AshCqrs.Command do
  @moduledoc """
  An extension for creating a command. See the getting started guide for more.
  """

  @command %Spark.Dsl.Section{
    name: :command,
    schema: [
      name: [
        type: {:atom},
        doc: """
        The unique name of the command.
        """,
        default: []
      ],
      pre_check_identities_with: [
        type: {:spark, Ash.Domain},
        doc: "A domain to use to precheck generated identities. Required by certain data layers."
      ],
      command_handler: [
        type: {:spark, AshCqrs.CommandHandler},
        doc: "The handler for the command execution.",
        required: true
      ]
    ]
  }

  @sections [@command]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
