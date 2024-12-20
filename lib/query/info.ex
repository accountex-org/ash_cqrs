defmodule AshCqrs.Query.Info do
  @moduledoc "Introspection helpers for the `AshCqrs.Query` DSL"
  use Spark.InfoGenerator, extension: AshCqrs.Query, sections: [:query]
end
