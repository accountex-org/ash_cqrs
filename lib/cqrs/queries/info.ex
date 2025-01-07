defmodule AshCqrs.Queries.Info do
  @moduledoc "Introspection helpers for `AshCqrs.Queries.Query` section"
  use Spark.InfoGenerator, extension: AshCqrs.Queries.Query,
      sections: [:queries]
end
