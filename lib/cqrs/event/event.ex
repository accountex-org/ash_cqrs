defmodule AshCqrs.Event do
  @moduledoc """
  An extension for creating a event part of the CQRS system.

  See the getting started guide for more.
  """

  # Defines the options schema for the event.
  @event_schema [
    event_name: [
      type: :atom,
      doc: "A unique atom identifying the name of the event.",
      required: true
    ],
    event_handler: [
      type: {:spark, AshCqrs.EventHandler},
      doc: "The handler for the event execution.",
      required: true
    ]
  ]

  # Defines the entity constructor for a event.
  @event %Spark.Dsl.Entity{
    name: :event,
    describe: """
    Declares a new event.
    """,
    examples: [],
    target: AshCqrs.Event,
    args: [:event_name, :event_handler],
    schema: @event_schema
  }

  # Declares the events section
  @events %Spark.Dsl.Section{
    name: :events,
    describe: """
    Configures what events will be available in the system.

    Events are used for updating the eventually consistent data.
    It is usually suggested to name them in the past tense.

    ## Example

    ```elixir
    events do
      event :user_created do,
        event_handler: UserCreatedHandler
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
