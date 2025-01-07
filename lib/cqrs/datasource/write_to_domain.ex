defmodule AshCqrs.WriteToDomain do
  @moduledoc "represents a normalized domain used for creating, updating and deleting data."
  @fields [
    :domain,
  ]

  defstruct @fields

  def fields, do: @fields

  @schema [
    domain: [
      type: {:spark, Ash.Domain},
      doc: """
      The `Ash.Domain` used for creating, updating and deleting data.

      Querying for data should be done using the `AshCqrs.ReadFromDomain`
      """
    ],
  ]

  def schema, do: @schema


end
