defmodule HoTTPotato.Message.Header.DateTest do
  use ExUnit.Case, async: true

  alias HoTTPotato.Message.Header.Date, as: HeaderDate

  #######
  # API #
  #######

  test "&encode/1" do
    dt =
      DateTime.utc_now()
      |> struct(day: 1)
      |> struct(month: 5)
      |> struct!(year: 2018)
      |> struct!(hour: 2)
      |> struct!(minute: 3)
      |> struct!(second: 4)
    actual =
      dt
      |> HeaderDate.new()
      |> HeaderDate.encode()
      |> IO.iodata_to_binary()
    expected = "Date: Tue, 01 May 2018 02:03:04 UTC\r\n"
    assert actual == expected
  end

  test "&new/1" do
    assert match?(%HeaderDate{}, HeaderDate.new())
  end

  ##########################
  # Private / Undocumented #
  ##########################

  test "&day_of_month/1" do
    assert HeaderDate.day_of_month(1) == "01"
    assert HeaderDate.day_of_month(10) == "10"
  end

  test "&day_of_week/3" do
    assert HeaderDate.day_of_week(2018, 5, 1) == "Tue"
    assert HeaderDate.day_of_week(2018, 5, 2) == "Wed"
    assert HeaderDate.day_of_week(2018, 5, 3) == "Thu"
    assert HeaderDate.day_of_week(2018, 5, 4) == "Fri"
    assert HeaderDate.day_of_week(2018, 5, 5) == "Sat"
    assert HeaderDate.day_of_week(2018, 5, 6) == "Sun"
    assert HeaderDate.day_of_week(2018, 5, 7) == "Mon"
  end

  test "&hour/1" do
    assert HeaderDate.hour(1) == "01"
    assert HeaderDate.hour(10) == "10"
  end

  test "&minute/1" do
    assert HeaderDate.minute(1) == "01"
    assert HeaderDate.minute(10) == "10"
  end

  test "&month/1" do
    assert HeaderDate.month(1) == "Jan"
    assert HeaderDate.month(2) == "Feb"
    assert HeaderDate.month(3) == "Mar"
    assert HeaderDate.month(4) == "Apr"
    assert HeaderDate.month(5) == "May"
    assert HeaderDate.month(6) == "Jun"
    assert HeaderDate.month(7) == "Jul"
    assert HeaderDate.month(8) == "Aug"
    assert HeaderDate.month(9) == "Sep"
    assert HeaderDate.month(10) == "Oct"
    assert HeaderDate.month(11) == "Nov"
    assert HeaderDate.month(12) == "Dec"
  end

  test "&second/1" do
    assert HeaderDate.second(1) == "01"
    assert HeaderDate.second(10) == "10"
  end

  test "&year/1" do
    assert HeaderDate.year(1) == "0001"
    assert HeaderDate.year(10) == "0010"
    assert HeaderDate.year(100) == "0100"
    assert HeaderDate.year(1000) == "1000"
  end
end
