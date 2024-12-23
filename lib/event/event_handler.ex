defmodule AshCqrs.EventHandler do
  @moduledoc """
  An extension for creating an event handler. See the getting started guide for more.
  """

  @event_handler %Spark.Dsl.Section{
    name: :event_handler,
    schema: [
      handler_for: [
        type: {:spark, AshCqrs.EventHandler},
        doc: """
        The `AshCqrs.EventHandler` to be handled by this handler.
        """,
        require: true
      ],
      handle_with_action: [
        type: {:spark, Ash.Resource.Actions.Action},
        doc: """
        The `Ash.Resource.Actions.Action` used to handle the event.

        Mutually exclusive with the `handle_with_saga` option.
        """,
        required: false
      ],
      handle_with_saga: [
        type: {:spark, Ash.Reactor},
        doc: """
        The `Ash.Reactor` used to handle the event.

        Mutually exclusive with the `handle_with_action` option.
        """,
        required: false
      ]
    ]
  }

  @sections [ @event_handler]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
