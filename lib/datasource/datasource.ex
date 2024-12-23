defmodule AshCqrs.DataSource do
  @moduledoc """
  An extension for declaring a data source. See the getting started guide for more.
  """

  @data_source %Spark.Dsl.Section{
    name: :datasource,
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


  @sections [@data_source]
  @transformers []

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
