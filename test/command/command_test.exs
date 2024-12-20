defmodule AshCqrs.CommandTest do
  use ExUnit.Case
  doctest Cqrs

  defmodule TestResource do
    use Ash.Resource,
      domain: CommandTest.Domain,
      data_layer: Ash.DataLayer.Ets,
      extensions: [AshCqrs.Command]

    ets do
      private? true
    end

    command do
      command_name :test_command
      command_handler
    end


    attributes do
      attribute :is_active, :boolean do
        default true
      end
    end
  end


  defmodule Domain do
    use Ash.Domain

    resources do
      resource TestResource
    end
  end

end
