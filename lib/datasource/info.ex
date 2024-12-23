defmodule AshCqrs.DataSource.Info do
  @moduledoc "Introspection helpers for `AshCqrs.DataSource` DSL"
  use Spark.InfoGenerator, extension: AshCqrs.DataSource, sections: [:data_source]
end
