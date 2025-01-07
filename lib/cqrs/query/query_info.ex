defmodule AshCqrs.QueryInfo do
  @moduledoc "Introspection helpers for the `AshCqrs.Query` DSL"
  use Spark.InfoGenerator, extension: AshCqrs.Query, sections: [:query, :query_handler]
end
