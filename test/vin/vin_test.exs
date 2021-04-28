defmodule Vin.VinTest do
  use ExUnit.Case
  alias Vin.Vin

  describe "check digit calculation" do
    test "is_valid_length?/1" do
      string_of_ones = fn rng -> rng |> Enum.map(fn _ -> "1" end) |> Enum.join() end
      refute string_of_ones.(1..16) |> Vin.is_valid_length?()
      assert string_of_ones.(1..17) |> Vin.is_valid_length?()
      refute string_of_ones.(1..18) |> Vin.is_valid_length?()
    end

    test "check_digit/1" do
      assert Vin.check_digit("1M8GDM9A_KP042788") == "X"
      assert Vin.check_digit("11111111111111111") == "1"
    end
  end
end
