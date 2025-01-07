defmodule AshCqrs.Events.Event do
  @moduledoc """
  An extension for defining an event to be processed by the CQRS system.

  """

  # Defines the options schema for the event.
  @event_schema [
    name: [
      type: :atom,
      doc: "A unique atom identifying the name of the event.",
      required: true
    ],
    description: [
      type: :string,
      doc: "An optional description for the event.",
      required: false
    ],
    handler: [
      type: {:one_of, [
          {:spark, Ash.Resource.Actions.Action},
          {:spark, Ash.Reactor}
        ]},
      doc: """
      Either an `Ash.Resource.Actions.Action` for simple processing or an
      `Ash.Reactor` for more complex business logic handling.
      """
    ],
    args: [
      type: {:list, {:spark, Ash.Resource.Actions.Argument}},
      doc: """
      The arguments required for event processing.
      """,
      required: false
    ]
  ]

  # Defines the entity constructor for a event.
  @event %Spark.Dsl.Entity{
    name: :event,
    describe: """
    Defines a new event
    """,
    examples: [],
    target: AshCqrs.Events.Event,
    args: [:name, :description, :handler, :args],
    schema: @event_schema
  }

  # Declares the events section
  @events %Spark.Dsl.Section{
    name: :events,
    describe: """
    Configures what events will be available in the system.

    Events are used for effectful changes to the system.
    They usually involve some sort of persistence of the data but not necessarily.

    ## Example

    ```elixir
    events do
      event do
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
    entities: [@event],
  }


  @sections [@events]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
