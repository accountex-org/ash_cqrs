defmodule AshCqrs.Command do
  @moduledoc """
  An extension for creating a command. See the getting started guide for more.
  """

  @command %Spark.Dsl.Section{
    name: :command,
    schema: [
      command_name: [
        type: {:atom},
        doc: "A unique name of the command.",
        required: true
      ],
      pre_check_identities_with: [
        type: {:spark, Ash.Domain},
        doc: "A domain to use to precheck generated identities. Required by certain data layers.",
        required: false
      ],
      ressources: [
        type: {:list, Ash.Resource},
        doc: "A list of ressources required by the command.",
        default: false
      ],
      command_handler: [
        type: {:spark, AshCqrs.CommandHandler},
        doc: "The handler for the command execution.",
        required: true
      ]
    ]
  }


  @command_handler %Spark.Dsl.Section{
    name: :command_handler,
    schema: [
      handle_with_action: [
        type: {:spark, Ash.Resource.Actions.Action},
        doc: """
        The `Ash.Resource.Actions.Action` used to handle the command.

        Mutually exclusive with the `handle_with_saga` option.
        """,
        required: false
      ],
      handle_with_saga: [
        type: {:spark, Ash.Reactor},
        doc: """
        The `Ash.Reactor` used to handle the command.

        Mutually exclusive with the `handle_with_action` option.
        """,
        required: false
      ]
    ]
  }

  @sections [@command, @command_handler]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
