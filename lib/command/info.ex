defmodule AshCqrs.Command.Info do
  @moduledoc "Introspection helpers for `AshCqrs.Command`"
  use Spark.InfoGenerator, extension: AshCqrs.Command, sections: [:command]
end
