defmodule AshCqrs.QueryInfo do
  @moduledoc "Introspection helpers for `AshCqrs.Query`"
  use Spark.InfoGenerator, extension: AshCqrs.Query, sections: [:query]
end
