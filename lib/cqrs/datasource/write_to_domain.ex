defmodule AshCqrs.WriteToDomain do
  @moduledoc "represents a normalized domain used for creating, updating and deleting data."
  @fields [
    :domain,
  ]

  defstruct @fields

  def fields, do: @fields

  @schema [
    domain: [
      type: :module,
      doc: "the `ash.domain` to use for writing."
    ],
  ]

  def schema, do: @schema


end
