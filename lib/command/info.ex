defmodule AshCqrs.Command.Info do
  @moduledoc "Introspection helpers for `AshCqrs.Command` DSL"
  use Spark.InfoGenerator, extension: AshCqrs.Command, sections: [:command, :command_handler]
end