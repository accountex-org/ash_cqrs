defmodule AshCqrs.DataSource do
  @moduledoc """
  An extension for declaring a data source. See the getting started guide for more.
  """

  @data_source %Spark.Dsl.Section{
    name: :datasource,
      doc: """
      Please note that the :write_to and :read_from domains should preferably use two different `Ecto.Repo`
      to take advantage of the CQRS pattern.

      For better scalability the :read_fom domain could use a different `Ash.DataLayer` optimized for reading.
      """,
    schema: [
      datasource_name: [
        type: {:atom},
        doc: "A unique atom identifying the data source.",
        required: true
      ],
      write_to: [
        type: {:atom, Ash.Domain},
        doc: """
        The `Ash.Domain` with normalized ressources to write to.
        """,
        required: true
      ],
      read_from: [
        type: {:atom, Ash.Domain},
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
