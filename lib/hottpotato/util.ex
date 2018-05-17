defmodule HoTTPotato.Util do
  require HoTTPotato.Util.UUID, as: UUID

  @type uuid :: HoTTPotato.Util.UUID.t()

  @doc """
  Generates a [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier).  The default is a version 4 UUID in iodata format.
  """
  @spec uuid() :: uuid()
  def uuid(version \\ 4, format \\ :iodata), do: UUID.uuid(version, format)
end
