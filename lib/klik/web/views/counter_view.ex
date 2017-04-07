defmodule Klik.Web.CounterView do
  use Klik.Web, :view

  def counter_name(%{name: nil}), do: "Counter"
  def counter_name(%{name: name}), do: name

  def channelId(counter) do
    Klik.Web.CounterChannel.id(counter)
  end

  def number_with_leading_zeros(number, length \\ 5) do
    number
    |> Integer.to_string
    |> String.pad_leading(length, "0")
  end

end
