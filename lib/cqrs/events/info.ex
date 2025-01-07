defmodule AshCqrs.Events.Info do
  @moduledoc "Introspection helpers for `AshCqrs.Eventsi.Event` section"
  use Spark.InfoGenerator, extension: AshCqrs.Events.Event,
      sections: [:events]
end
