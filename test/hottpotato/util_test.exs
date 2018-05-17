defmodule HoTTPotato.UtilTest do
  use ExUnit.Case, async: true
  alias HoTTPotato.Util

  describe "&uuid/2" do
    test "has default args && does not raise error" do
      assert Util.uuid()
    end
  end
end
