defmodule AshCqrs.CommandInfo do
  @moduledoc "Introspection helpers for `AshCqrs.Commands` section"
  use Spark.InfoGenerator, extension: AshCqrs.Command,
      sections: [:commands, :command_handlers]
end
