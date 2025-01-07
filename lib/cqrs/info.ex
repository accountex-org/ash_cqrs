defmodule AshCqrs.Info do
  @moduledoc "Introspection tools for AshCqrs.Cqrs"

  alias Spark.Dsl.Extension

  @doc """
  Gets the commands defined for a CQRS module.
  """
  @spec commands(Spark.Dsl.t() | AshCqrs.Commands.Command.t()) :: list(AshCqrs.Commands.Command.t() | Spark.Dsl.Entity.t() | Spark.Dsl.EntityModule.t())
  def commands(cqrs) do
    cqrs
    |> Extension.get_entities([:commands])
    |> Enum.map(& &1.command)
  end

  @doc """
  Gets the queries defined for a CQRS module.
  """
  @spec queries(Spark.Dsl.t() | AshCqrs.Queries.Query.t()) :: list(AshCqrs.Queries.Query.t() | Spark.Dsl.Entity.t() | Spark.Dsl.EntityModule.t())
  def queries(cqrs) do
    cqrs
    |> Extension.get_entities([:queries])
    |> Enum.map(& &1.query)
  end

  @doc """
  Gets the events defined for a CQRS module.
  """
  @spec events(Spark.Dsl.t() | AshCqrs.Events.Event.t()) :: list(AshCqrs.Events.Event.t() | Spark.Dsl.Entity.t() | Spark.Dsl.EntityModule.t())
  def events(cqrs) do
    cqrs
    |> Extension.get_entities([:events])
    |> Enum.map(& &1.event)
  end

end
