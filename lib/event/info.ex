defmodule AshCqrs.Event.Info do
  @moduledoc "Introspection helpers for the `AshCqrs.Event` DSL."
  use Spark.InfoGenerator, extension: AshCqrs.Event, sections: [:event, :event_handler]
end
