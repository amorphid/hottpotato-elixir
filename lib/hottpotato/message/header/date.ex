alias HoTTPotato.Message.HeaderEncoder
alias HoTTPotato.Message.Header.Date, as: HeaderDate

defmodule HeaderDate do
  defstruct [
    :name,
    :value
  ]

  @type datetime :: DateTime.t()
  @type name :: String.t()
  @type t :: %__MODULE__{
    name: name(),
    value: datetime()
  }

  #######
  # API #
  #######

  @spec encode(t()) :: [String.t(), ...]
  def encode(%__MODULE__{} = hd) do
    HeaderEncoder.encode(hd)
  end

  @spec new(DateTime.t()) :: t()
  def new(%DateTime{} = dt \\ DateTime.utc_now()) do
    __MODULE__
    |> struct!(name: "Date")
    |> struct!(value: dt)
  end

  ##########################
  # Private / Undocumented #
  ##########################

  @doc false
  @spec day_of_month(non_neg_integer()) :: String.t()
  def day_of_month(int)

  def day_of_month(int) when int < 10, do: "0#{int}"

  def day_of_month(int), do: "#{int}"

  @doc false
  @spec day_of_week(non_neg_integer(), non_neg_integer(), non_neg_integer()) :: String.t()
  def day_of_week(year, month, day) do
    case Calendar.ISO.day_of_week(year, month, day) do
      1 -> "Mon"
      2 -> "Tue"
      3 -> "Wed"
      4 -> "Thu"
      5 -> "Fri"
      6 -> "Sat"
      7 -> "Sun"
    end
  end

  @doc false
  @spec hour(non_neg_integer()) :: String.t()
  def hour(int)

  def hour(int) when int < 10, do: "0#{int}"

  def hour(int), do: "#{int}"

  @doc false
  @spec minute(non_neg_integer()) :: String.t()
  def minute(int)

  def minute(int) when int < 10, do: "0#{int}"

  def minute(int), do: "#{int}"

  @doc false
  @spec month(non_neg_integer()) :: String.t()
  def month(int) do
    case int do
      1 -> "Jan"
      2 -> "Feb"
      3 -> "Mar"
      4 -> "Apr"
      5 -> "May"
      6 -> "Jun"
      7 -> "Jul"
      8 -> "Aug"
      9 -> "Sep"
      10 -> "Oct"
      11 -> "Nov"
      12 -> "Dec"
    end
  end

  @doc false
  @spec second(non_neg_integer()) :: String.t()
  def second(int)

  def second(int) when int < 10, do: "0#{int}"

  def second(int), do: "#{int}"

  @doc false
  @spec year(non_neg_integer()) :: String.t()
  def year(int)

  def year(int) when int < 10, do: "000#{int}"

  def year(int) when int < 100, do: "00#{int}"

  def year(int) when int < 1000, do: "0#{int}"

  def year(int), do: "#{int}"
end

defimpl HeaderEncoder, for: HeaderDate do
  #######
  # API #
  #######

  @doc """
  Based on format in [RFC 7766](https://tools.ietf.org/html/rfc2616#page-20)
  """
  @spec encode(HeaderDate.t()) :: [String.t(), ...]
  def encode(%HeaderDate{name: name, value: %DateTime{} = dt}) do
    [
      name,
      ": ",
      HeaderDate.day_of_week(dt.year, dt.month, dt.day),
      ", ",
      HeaderDate.day_of_month(dt.day),
      " ",
      HeaderDate.month(dt.month),
      " ",
      HeaderDate.year(dt.year),
      " ",
      HeaderDate.hour(dt.hour),
      ":",
      HeaderDate.minute(dt.minute),
      ":",
      HeaderDate.second(dt.second),
      " ",
      dt.zone_abbr,
      "\r\n"
    ]
  end
end
