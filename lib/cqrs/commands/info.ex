defmodule AshCqrs.Commands.Info do
  @moduledoc "Introspection helpers for `AshCqrs.Commandsi.Command` section"
  use Spark.InfoGenerator, extension: AshCqrs.Commands.Command,
      sections: [:commands]
end
