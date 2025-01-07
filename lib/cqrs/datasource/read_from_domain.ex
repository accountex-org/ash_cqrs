defmodule AshCqrs.ReadFromDomain do
  @moduledoc "Represents a optimized domain used for reading ata."
  @fields [
    :domain,
  ]

  defstruct @fields

  def fields, do: @fields

  @schema [
    domain: [
      type: {:spark, Ash.Domain},
      doc: """
      The `Ash.Domain` used for querying data.

      Writing, updating and deleting data should be done using the `AshCqrs.WriteToDomain`
      """
    ],
  ]

  def schema, do: @schema

end
