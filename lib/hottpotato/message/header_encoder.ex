defprotocol HoTTPotato.Message.HeaderEncoder do
  def encode(header)
end

[
  Any,
  Atom,
  BitString,
  Float,
  Function,
  Integer,
  List,
  Map,
  PID,
  Port,
  Reference,
  Tuple
]
|> Enum.map(fn type ->
  defimpl HoTTPotato.Message.HeaderEncoder, for: type do
    def encode(invalid), do: raise "invalid header: #{inspect(invalid)}"
  end
end)
