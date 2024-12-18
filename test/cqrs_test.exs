defmodule CqrsTest do
  use ExUnit.Case
  doctest Cqrs

  test "greets the world" do
    assert Cqrs.hello() == :world
  end
end
