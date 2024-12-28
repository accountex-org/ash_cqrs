defmodule AshCqrs.DataSourceInfo do
  @moduledoc "Introspection helpers for `AshCqrs.DataSource` DSL"
  use Spark.InfoGenerator, extension: AshCqrs.DataSource, sections: [:datasource]
end
