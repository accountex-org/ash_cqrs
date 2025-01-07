defmodule AshCqrs.EventBus do
  use Ash.Type.Enum, values: [:event_bus, :broadway]
end
