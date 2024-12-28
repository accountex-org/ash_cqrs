defmodule AshCqrs.Event do
  @moduledoc """
  An extension for creating a event. See the getting started guide for more.
  """

  @event %Spark.Dsl.Section{
    name: :event,
    schema: [
      event_name: [
        type: :atom,
        doc: "A unique name of the event.",
        required: true
      ],
      event_handler: [
        type: {:spark, AshCqrs.EventHandler},
        doc: "The handler used for event execution.",
        required: true
      ]
    ]
  }


  @sections [@event]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
