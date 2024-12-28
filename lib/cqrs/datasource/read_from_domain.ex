defmodule AshCqrs.ReadFromDomain do
  @moduledoc "Represents a optimized domain used for reading ata."
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
