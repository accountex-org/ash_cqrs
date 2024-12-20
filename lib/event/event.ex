defmodule AshCqrs.Event do
  @moduledoc """
  An extension for creating a event. See the getting started guide for more.
  """

  @event %Spark.Dsl.Section{
    name: :event,
    schema: [
      event_name: [
        type: {:atom},
        doc: "A unique name of the event.",
        required: true
      ],
      pre_check_identities_with: [
        type: {:spark, Ash.Domain},
        doc: "A domain to use to precheck generated identities. Required by certain data layers.",
        required: false
      ],
      ressources: [
        type: {:list, Ash.Resource},
        doc: "A list of ressources required by the event.",
        default: false
      ],
      event_handler: [
        type: {:spark, AshCqrs.EventHandler},
        doc: "The handler for the event execution.",
        required: true
      ]
    ]
  }


  @event_handler %Spark.Dsl.Section{
    name: :event_handler,
    schema: [
      handler_for: [
        type: {:spark, AshCqrs.Event},
        doc: """
        The `AshCqrs.Events.Event` to be handled by this handler.
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

  @sections [@event, @event_handler]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
