defmodule HoTTPotato.Util.UUIDTest do
  use ExUnit.Case, async: true
  alias HoTTPotato.Util.UUID

  def uuid(version, format) do
    version
    |> UUID.uuid(format)
    |> IO.iodata_to_binary()
  end

  def pattern(4) do
    ~r/[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[0-9a-f]{4}-[0-9a-f]{12}/
  end

  #######
  # API #
  #######

  describe "&uuid/2" do
    test "version 4 format" do
      assert uuid(4, :iodata) =~ pattern(4)
    end
  end

  ##########################
  # Private / Undocumented #
  ##########################

  describe "&bin_to_hex/1" do
    test "returns hex" do
      assert UUID.int_to_hex(0) == 48
      assert UUID.int_to_hex(1) == 49
      assert UUID.int_to_hex(2) == 50
      assert UUID.int_to_hex(3) == 51
      assert UUID.int_to_hex(4) == 52
      assert UUID.int_to_hex(5) == 53
      assert UUID.int_to_hex(6) == 54
      assert UUID.int_to_hex(7) == 55
      assert UUID.int_to_hex(8) == 56
      assert UUID.int_to_hex(9) == 57
      assert UUID.int_to_hex(10) == 97
      assert UUID.int_to_hex(11) == 98
      assert UUID.int_to_hex(12) == 99
      assert UUID.int_to_hex(13) == 100
      assert UUID.int_to_hex(14) == 101
      assert UUID.int_to_hex(15) == 102
    end
  end
end
