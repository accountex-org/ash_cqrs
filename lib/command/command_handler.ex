defmodule AshCqrs.CommandHandler do
  @moduledoc """
  An extension for creating a command. See the getting started guide for more.
  """

  @command_handler %Spark.Dsl.Section{
    name: :command_handler,
    schema: [
      handler_for: [
        type: {:spark, AshCqrs.Command},
        doc: """
        The `AshCqrs.command` to be handled.
        """,
        require: true
      ],
      handle_with: [
        type: {:spark, Ash.Resource.Actions.Action},
        doc: "The `Ash.Resource.Actions.Action` used to handle the command.",
        required: true
      ]
    ]
  }

  @sections [@command_handler]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
