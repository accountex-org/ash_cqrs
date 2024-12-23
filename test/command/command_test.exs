defmodule AshCqrs.CommandTest do
  use ExUnit.Case
  doctest Cqrs

  # Ressource to be used in tests
  defmodule TestResource do
    use Ash.Resource,
      domain: CommandTest.Domain,
      data_layer: Ash.DataLayer.Ets,
      extensions: [AshCqrs.Command]

    ets do
      private? true
    end

    command do
      command_name: CommandTest.Command1,
      command_handler: CommandTest.CommandHandler1
    end


    attributes do
      attribute :is_active, :boolean do
        default true
      end
    end
  end

  # Domain to be used in tests
  defmodule Domain do
    use Ash.Domain

    resources do
      resource TestResource
    end
  end
end
