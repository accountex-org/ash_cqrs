defmodule AshCqrs.Events.EventBus do
  use Ash.Type.Enum, values: [:event_bus, :broadway]
end
