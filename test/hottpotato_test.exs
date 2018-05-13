defmodule HoTTPotatoTest do
  use ExUnit.Case
  doctest HoTTPotato

  test "greets the world" do
    assert HoTTPotato.hello() == :world
  end
end
