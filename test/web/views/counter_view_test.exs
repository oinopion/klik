defmodule Klik.Web.CounterViewTest do
  use Klik.Web.ConnCase, async: true

  alias Klik.Web.CounterView

  test "number_with_leading_zeros/2 padds number with zeros" do
    assert CounterView.number_with_leading_zeros(1, 5) == "00001"
    assert CounterView.number_with_leading_zeros(10, 5) == "00010"
    assert CounterView.number_with_leading_zeros(12345, 5) == "12345"
    assert CounterView.number_with_leading_zeros(987654321, 5) == "987654321"
  end
end
