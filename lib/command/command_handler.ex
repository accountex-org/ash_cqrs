defmodule AshCqrs.CommandHandler do
  @moduledoc """
  An extension for creating a command handler. See the getting started guide for more.
  """

  @command_handler %Spark.Dsl.Section{
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
    ]
  }

  @sections [@command_handler]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
