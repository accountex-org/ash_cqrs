defmodule AshCqrs.CommandTest do
  use ExUnit.Case
  doctest Cqrs

  defmodule Command do
    use Ash.Resource,
      domain: CommandTest.Domain,
      data_layer: Ash.DataLayer.Ets,
      extensions: [AshCqrs.Command]

    ets do
      private? true
    end

    command do
      pre_check_identities_with AshCqrs.CommandTest.Domain
      transfer_resource AshDoubleEntryTest.Transfer
      balance_resource AshDoubleEntryTest.Balance
      open_action_accept [:allow_zero_balance]
    end

    attributes do
      attribute :allow_zero_balance, :boolean do
        default true
      end
    end
  end

  test "greets the world" do
    assert Cqrs.hello() == :world
  end
end
