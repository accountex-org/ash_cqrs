defmodule AshCqrs.Dsl do
  @moduledoc """
  Top level DSL for the CQRS extension.

  ## DataSource
  The DataSource represents the two facets of the CQRS pattern and defines the two
  domains that will be used for either the commands or queries.

  One of the main concepts in a CQRS system is to have two separate data repositories.
  One data repository should contain data in a nomralized shema for writing and updating data through
  the relationships in the database. The second data repository on the other hand should contain data
  in a format that is optimized for query performance by removing the need of going throuh the \
  relationship every time.

  Expressing this duality is the purpose of the `AshCqrs.DataSource`.

  ## Command

  The CQRS pattern puts an emphasis on the separation of concerns between updating and querying for data.
  This separation of concerns allows to scale both side of the equation to different levels depending on
  the specific needs of that side.

  The `AshCqrs.Command` encapsulate the writable side of this duality of purpose.
  The :command  should thus used a separate `Ash.Domain` to define the resources in a normalized
  schema. These :command will then be routed to a predefined :command_handler.

  A simple :command_handler can be redirected to an `Ash.Actions.Action`.
  More complex :command_handler can ne redirected to a `Reactor` saga for processing.

  ## Query

  The `AshCqrs.Query` encapsulate the read-only side of the CQRS duality of purpose.
  The :query  should thus used a separate `Ash.Domain` to define the resources in a flattened
  schema. These :query will then be routed to a predefined :query_handler.

  Please note that the ressources on the read-only sie will  only be eventually consistent with
  the writable side.

  ## Events

  Events are the magic linking the writable domain to the eventually consistent readly only domain.
  The :command_handler should be the main source of :event dispatch and notify the event-bus used
  for procesing the events of the changes that were made to the writable domain.

  It is the task of the events processor to keep both side in sync.
  The events processor will be part of a message queue processing ssytem in order to make sure that
  all changes to the writable domain will be properly reflected in the eventually consistent one.

  No changes should ever be made directly to the ressources of the query side.

  """

  @cqrs %Spark.Dsl.Section{
    name: :cqrs,
    schema: [
      name: [
        type: :atom,
        doc: "A unique atom identifying the data source.",
        required: true
      ],
      write_to: [
        type: {:spark, Ash.Domain},
        doc: """
        The `Ash.Domain` with normalized ressources to write to.
        """,
        required: true
      ],
      read_from: [
        type: {:spark, Ash.Domain},
        doc: """
        The `Ash.Domain` with ressources optimized for reading from.
        """,
        required: true
      ],
    ]
  }


  @sections [@cqrs]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
