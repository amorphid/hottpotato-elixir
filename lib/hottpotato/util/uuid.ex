defmodule HoTTPotato.Util.UUID do
  @type bin_list :: iodata()
  @type bytes :: <<_::_*8>>
  @type format :: :iodata
  @type hex :: iodata()
  @type t :: iodata()
  @type version :: pos_integer()

  #######
  # API #
  #######

  @spec uuid(version(), format()) :: t()
  def uuid(version, format) do
    get_bytes(version) |> format_bytes(format)
  end

  ##########################
  # Private / Undocumented #
  ##########################

  @doc false
  @spec bin_to_hex(bytes()) :: hex()
  def bin_to_hex(bin) do
    :binary.bin_to_list(bin) |> list_to_hex()
  end

  @doc false
  @spec format_bytes(bytes(), format()) :: t()
  def format_bytes(<<g0::32, g1::16, g2::16, g3::16, g4::48>>, :iodata) do
    [
      bin_to_hex(<<g0::32>>),
      ?-,
      bin_to_hex(<<g1::16>>),
      ?-,
      bin_to_hex(<<g2::16>>),
      ?-,
      bin_to_hex(<<g3::16>>),
      ?-,
      bin_to_hex(<<g4::48>>)
    ]
  end

  @doc false
  @spec get_bytes(version()) :: bytes()
  def get_bytes(4) do
    <<h::48, _::4, t::76>> = :crypto.strong_rand_bytes(16)
    <<h::48, 4::4, t::76>>
  end

  @doc false
  @spec int_to_hex(pos_integer()) :: pos_integer()
  def int_to_hex(int) do
    case rem(int, 16) do
      i when i < 10 -> i + 48 # 0 thru 9
      i -> i + 87 # a thru f
    end
  end

  @doc false
  @spec list_to_hex(bin_list()) :: hex()
  def list_to_hex(bin_list)

  def list_to_hex([]) do
    []
  end

  def list_to_hex([h | t]) do
    h0 = trunc(h / 16)
    h1 = rem(h, 16)
    [int_to_hex(h0), int_to_hex(h1)] ++ list_to_hex(t)
  end
end
